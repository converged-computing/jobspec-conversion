import argparse
import os
import csv
import json
import sys
import fnmatch
import pandas
import subprocess
import seaborn as sns
import matplotlib.pylab as plt
from io import StringIO
import tempfile
import statistics

from flux.job.directives import DirectiveParser
from flux.cli.batch import BatchCmd

# You also need:
# mkdir -p ./bin
# curl -fsSL https://git.io/shellmetrics > ./bin/shellmetrics
# chmod +x ./bin/shellmetrics
# export PATH=$PWD/bin:$PATH

# Valdiate job specs, and summarize metadata and determine reasons for being
# valid or not. This should be run in a docker container or with flux.
# docker run -it -v $PWD/:/data fluxrm/flux-sched:jammy
# cd /data
# sudo apt-get update && apt-get install -y python3-pandas python3-seaborn
# python validate-jobspecs.py
here = os.path.abspath(os.path.dirname(__file__))


class Validator(BatchCmd):
    def derive_failure_reason(self, message):
        """
        Why did the directive parsing fail?
        """
        line = None
        if "line" in message:
            line = int(message.split("line", 1)[-1].split(":", 1)[0])

        # E.g., # # Flux
        if "sentinel changed" in message:
            return "sentinel changed", line

        # Directive after top of script
        if "orphan 'flux:'" in message.lower():
            return "orphan flux", line

        if "unknown directive" in message.lower():
            return "unknown directive", line
        print("Unseen issue with parsing directive, investigate:")
        print(message)
        import IPython

        IPython.embed()

    def get_directive_parser(self, content, changes=None):
        """
        Read batch script into string, and get directive parser

        If failure is due to a line that can be removed, do it.
        """
        if changes is None:
            changes = []
        string_io = StringIO(content)
        try:
            batchscript = DirectiveParser(string_io)
        except Exception as e:
            string_io.close()
            reason, line = self.derive_failure_reason(" ".join(e.args))
            if line is not None:
                lines = content.split("\n")
                deleted_line = lines[line - 1]
                changes.append({"line": deleted_line, "reason": reason})
                del lines[line - 1]
                return self.get_directive_parser("\n".join(lines), changes)
            else:
                print("The error message did not return a line, take a look why.")
                import IPython

                IPython.embed()
        string_io.close()
        return batchscript, changes

    def validate(self, filename):
        """
        Validate a batch script filename.
        """
        content = read_file(filename)

        # Changes are removed lines to get it to read
        batchscript, changes = self.get_directive_parser(content)

        # Total number of args so we can calculate how many we got wrong
        total_args = len(batchscript.directives)
        correct_args = 0
        wrong_args = 0
        # SETARGS(['--tasks=5'])
        # SETARGS(['-N', '1'])
        # SETARGS(['-c', '10'])
        # SETARGS(['--mem-per-task=40G'])
        # SETARGS(['--gpus-per-task=1'])
        # SETARGS(['-t', '2h'])
        # SETARGS(['--queue=learnfair'])
        # SETARGS(['--job-name=train_pfl_array'])
        # SETARGS(['--output=/checkpoint/pillutla/pfl/outs/flux_{jobid}.{taskid}.out'])
        # SETARGS(['--error=/checkpoint/pillutla/pfl/outs/flux_{jobid}.{taskid}.err'])
        for item in batchscript.directives:
            try:
                print(item)
                if item.action == "SETARGS":
                    self.parser.parse_args(item.args)
                else:
                    print("We probably should not get here...")
                    import IPython

                    IPython.embed()
            except Exception:
                wrong_args += 1
                continue
            except SystemExit:
                name = " ".join(item.args)
                print(f"validation failed at {name} line {item.lineno}")
                wrong_args += 1
                continue
            correct_args += 1
        return {
            "correct": correct_args,
            "wrong_args": wrong_args,
            "total_args": total_args,
            "deletions": changes,
            "filename": filename,
        }


def calculate_complexity(filepath):
    """
    Use shellmetrics to calculate complexity.

    This returns one line per complexity. We are going to return an
    average across functions for one value, but note we could get partial
    breakdown if desired.
    """
    p = subprocess.Popen(
        ["shellmetrics", "--csv", filepath],
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE,
    )
    out, err = p.communicate()
    out = out.decode("utf-8")

    # Use stringio to read the csv into csv parser
    f = StringIO(out)
    reader = csv.reader(f, delimiter=",")
    rows = list(reader)

    # The main is always the second row
    if rows[0][4] != "ccn":
        raise ValueError(f"Unexpected column headers for {filepath}:\n{out}")
    # This is the ccn score for <main> - it is a string parsed to int

    ccns = []
    for row in rows[1:]:
        # These don't seem to be included in the mean ccn in the pretty UI
        if row[1] in ["<begin>", "<end>"]:
            continue
        ccns.append(int(row[4]))

    # This should not happen, but for really simply stuff it seems to.
    # Let's give a value of 0
    if not ccns:
        print(f"Warning: no CCN scores found for {filepath}: assigning value of 0")
        return 0
    return statistics.mean(ccns)


# Helper functions
def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content


def recursive_find(base, pattern="*"):
    for root, _, filenames in os.walk(base):
        for filename in fnmatch.filter(filenames, pattern):
            yield os.path.join(root, filename)


def write_file(content, filename):
    with open(filename, "w") as fd:
        fd.write(content)


def write_json(obj, filename):
    with open(filename, "w") as fd:
        fd.write(json.dumps(obj, indent=4))


def get_parser():
    parser = argparse.ArgumentParser(description="Gemini Jobspec Generator")
    parser.add_argument(
        "--input",
        help="Input directory",
        default=os.path.join(here, "results"),
    )
    parser.add_argument(
        "--outdir",
        help="Output directory",
        default=tempfile.gettempdir(),
    )
    return parser


def main():
    parser = get_parser()
    args, _ = parser.parse_known_args()
    if not os.path.exists(args.input):
        sys.exit("An input directory is required.")

    # Read in flux jobs, these are already unique
    files = list(recursive_find(args.input, "*flux-batch.sh"))
    print(f"⭐️ Found {len(files)} Flux job scripts")

    validator = Validator("batch")
    results = []
    # For each, flux validate
    for i, filename in enumerate(files):
        results.append(validator.validate(filename))

    # Delete those with no deletions, har har har
    complete = []
    df = pandas.DataFrame(
        columns=[
            "total_directives",
            "correct_directives",
            "wrong_directives",
            "line_deletions",
            "complexity_score",
            "application",
            "cyclomatic_complexity",
        ]
    )
    idx = 0
    for res in results:
        if "deletions" in res and not res["deletions"]:
            del res["deletions"]

        # Complexity
        complexity = calculate_complexity(res["filename"])

        # Add in the metadata about complexity, etc.
        try:
            metadata = json.loads(
                read_file(res["filename"].replace("-flux-batch.sh", "-metadata.json"))
            )
            res["metadata"] = metadata
            score = res["metadata"]["complexity_score"]
            command = res["metadata"]["application"].split(" ")[0]
            if os.sep in command:
                command = os.path.basename(command)
        except:
            print(f"Manged json for {res['filename']}")
            score = None
            command = None

        res["cyclomatic_complexity"] = complexity
        complete.append(res)
        deletions = len(res.get("deletions", []))
        df.loc[idx, :] = [
            res["total_args"],
            res["correct"],
            res["wrong_args"],
            deletions,
            score,
            command,
            complexity,
        ]
        idx += 1

    # Calculate total correct, lines that were deleted were wrong
    accuracies = []
    for i, row in df.iterrows():
        denominator = row.total_directives + row.line_deletions
        if denominator == 0:
            accuracies.append(1)
        else:
            accuracies.append(row.correct_directives / denominator)
    df["accuracies"] = accuracies

    # Plot 1: Accuracies
    fig = plt.figure(figsize=(8, 6))
    gs = plt.GridSpec(1, 2, width_ratios=[1, 0])
    axes = []
    axes.append(fig.add_subplot(gs[0, 0]))
    axes.append(fig.add_subplot(gs[0, 1]))

    sns.set_style("whitegrid")
    sns.histplot(
        df,
        ax=axes[0],
        x="accuracies",
    )
    axes[0].set_title(
        f"JobSpec Conversion to Flux Accuracy (N={df.shape[0]})", fontsize=12
    )
    axes[0].set_xlabel("Percentage Directive Correct", fontsize=12)
    plt.tight_layout()

    print(f"Saving plots and results to {args.outdir}")
    plt.savefig(os.path.join(args.outdir, "gemini-jobspec-to-flux-accuracy.png"))
    plt.clf()

    # Save all data
    write_json(complete, os.path.join(args.outdir, "gemini-jobspec-to-flux.json"))

    # Plot 2: look at commands
    fig = plt.figure(figsize=(20, 6))
    gs = plt.GridSpec(1, 2, width_ratios=[1, 0])
    axes = []
    axes.append(fig.add_subplot(gs[0, 0]))
    axes.append(fig.add_subplot(gs[0, 1]))
    order = df["application"].value_counts().index.tolist()
    df["apps"] = pandas.Categorical(df["application"], categories=order, ordered=True)
    sns.histplot(df, ax=axes[0], x="apps")
    axes[0].set_title(f"JobSpec Applications (N={df.shape[0]})", fontsize=12)
    axes[0].set_xlabel("Application", fontsize=12)
    axes[0].tick_params(axis="x", rotation=90)
    print(f"Saving plots and results to {args.outdir}")
    plt.tight_layout()
    plt.savefig(os.path.join(args.outdir, "gemini-jobspec-applications.png"))
    plt.clf()

    # Plot 3: Accuracy vs scores
    fig = plt.figure(figsize=(10, 6))
    gs = plt.GridSpec(1, 2, width_ratios=[1, 0])
    axes = []
    axes.append(fig.add_subplot(gs[0, 0]))
    axes.append(fig.add_subplot(gs[0, 1]))
    sns.scatterplot(
        ax=axes[0],
        x=df["complexity_score"].tolist(),
        y=df["accuracies"].tolist(),
        color="orange",
        label="LLM Derived Complexity",
    )
    axes[0].set_title(
        f"JobSpec Complexity vs. Flux Conversion Accuracy (N={df.shape[0]})",
        fontsize=12,
    )
    sns.scatterplot(
        ax=axes[0],
        x=df["cyclomatic_complexity"].tolist(),
        y=df["accuracies"].tolist(),
        color="blue",
        label="Cyclomatic Complexity",
    )
    axes[0].set_title(
        f"JobSpec Complexity vs. Flux Conversion Accuracy (N={df.shape[0]})",
        fontsize=12,
    )
    plt.tight_layout()
    plt.savefig(os.path.join(args.outdir, "gemini-jobspec-complexity.png"))
    plt.clf()


if __name__ == "__main__":
    main()
