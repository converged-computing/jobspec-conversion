import argparse
import os
import json
import sys
import shutil
import fnmatch
import hashlib

from colorama import Fore, Style
from fractale.transformer import get_transformer, detect_transformer

here = os.path.abspath(os.path.dirname(__file__))

BUF_SIZE = 65536


# Helper functions
def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content


def recursive_find(base, pattern="*"):
    for root, _, filenames in os.walk(base):
        for filename in fnmatch.filter(filenames, pattern):
            yield os.path.join(root, filename)


def content_hash(filename):
    sha1 = hashlib.sha1()
    with open(filename, "rb") as f:
        while True:
            data = f.read(BUF_SIZE)
            if not data:
                break
            sha1.update(data)
    return sha1.hexdigest()


def write_file(content, filename):
    with open(filename, "w") as fd:
        fd.write(content)


def write_json(obj, filename):
    with open(filename, "w") as fd:
        fd.write(json.dumps(obj, indent=4))


def get_parser():
    parser = argparse.ArgumentParser(description="Manual Jobspec Generator")
    parser.add_argument(
        "--input",
        help="Input directory",
        default=os.path.join(here, "data"),
    )
    parser.add_argument(
        "--limit",
        help="Max number to generate",
        default=None,
        type=int,
    )
    parser.add_argument(
        "--output",
        help="Output data directory",
        default=os.path.join(here, "results", "manual", "parsed"),
    )
    return parser


def main():
    parser = get_parser()
    args, _ = parser.parse_known_args()

    if not os.path.exists(args.input):
        sys.exit("An input directory is required.")

    if not os.path.exists(args.output):
        os.makedirs(args.output)

    # Read in the jobspecs
    contenders = list(recursive_find(args.input))
    unknown_count = 0
    issue_parsing = 0
    issues = {}

    seen = set()
    files = []
    for filename in contenders:
        digest = content_hash(filename)
        if digest in seen:
            continue
        seen.add(digest)
        files.append(filename)

    print(f"⭐️ Found {len(files)} unique job scripts")
    print("\nPre-processing complete.")

    # Unknown jobspecs
    unknown_dir = os.path.join(here, "results", "manual", "unknown")
    if not os.path.exists(unknown_dir):
        os.makedirs(unknown_dir)

    count = 0
    if args.limit is None:
        args.limit = len(files)

    # Keep track of directives we cannot parse
    # First from the script into our structure
    directives_not_handled = {}
    managers = {}

    for _, filename in enumerate(files):
        outfile = args.output + os.sep + os.path.relpath(filename, args.input)

        # If we are successful, we will save script
        outfile_script = f"{outfile}-flux-batch.sh"
        original = read_file(filename)

        # If no from transformer defined, try to detect
        try:
            from_transformer_name = detect_transformer(filename)
        except:
            write_file(
                original, os.path.join(unknown_dir, f"unknown-{unknown_count}.sh")
            )
            unknown_count += 1
            print(
                Fore.LIGHTRED_EX
                + f"Missing from transformer for {filename}"
                + Style.RESET_ALL
            )
            continue

        if from_transformer_name not in managers:
            managers[from_transformer_name] = 0
        if from_transformer_name not in directives_not_handled:
            directives_not_handled[from_transformer_name] = {}
        managers[from_transformer_name] += 1

        # We are always converting to Flux from whatever
        from_transformer = get_transformer(from_transformer_name)
        to_transformer = get_transformer("flux")

        try:
            normalized_jobspec = from_transformer.parse(filename)
        except Exception as e:
            relative_name = os.path.relpath(filename, args.input)
            issues[relative_name] = str(e)
            issue_parsing += 1
            continue

        flux_script = to_transformer.convert(normalized_jobspec)

        for directive in from_transformer.unhandled(filename):
            if directive not in directives_not_handled[from_transformer_name]:
                directives_not_handled[from_transformer_name][directive] = 0
            directives_not_handled[from_transformer_name][directive] += 1

        # Create output directory
        outdir = os.path.dirname(outfile)
        if not os.path.exists(outdir):
            os.makedirs(outdir)

        # Otherwise, we got a flux batch script and json
        write_file(flux_script, outfile_script)

        # Also copy the original file, to have in one place
        copied = os.path.join(outdir, "original-script.sh")
        shutil.copyfile(filename, copied)
        count += 1
        if count > args.limit:
            print(
                Fore.LIGHTGREEN_EX
                + f"Reached limit {args.limit}, stopping."
                + Style.RESET_ALL
            )
            break

    print("\nProcessing complete.")

    # Save managers, etc.
    outdir = os.path.join(here, "results", "manual")
    write_json(managers, os.path.join(outdir, "managers.json"))
    write_json(issues, os.path.join(outdir, "issues.json"))
    write_json(
        directives_not_handled, os.path.join(outdir, "directives-not-handled.json")
    )
    print(f"Issue parsing {issue_parsing}/{len(files)}")


if __name__ == "__main__":
    main()
