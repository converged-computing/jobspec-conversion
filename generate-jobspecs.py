import google.generativeai as genai
from colorama import Fore, Back, Style
import argparse
import os
import json
import sys
import shutil
import fnmatch
import hashlib
import time

here = os.path.abspath(os.path.dirname(__file__))

# Notes:
# 1. sometimes we get partial output

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if not GEMINI_API_KEY:
    raise ValueError("GEMINI_API_KEY environment variable not set.")
genai.configure(api_key=GEMINI_API_KEY)

# Models
print([x.name for x in list(genai.list_models())])


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
    with open(filename, "rb", buffering=0) as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


def write_file(content, filename):
    with open(filename, "w") as fd:
        fd.write(content)


def write_json(obj, filename):
    with open(filename, "w") as fd:
        fd.write(json.dumps(obj, indent=4))


generation_config = {
    # Lower temperature for more deterministic, less creative output
    "temperature": 0.2,
    "top_p": 1,
    "top_k": 1,
    # # Increased to handle potentially long script outputs
    "max_output_tokens": 8192,
}

safety_settings = [
    {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
    {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
    {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
    {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"},
]

# Or "gemini-1.5-flash-latest" for potentially faster/cheaper with good quality
MODEL_NAME = "models/gemini-2.5-pro-preview-05-06"
model = genai.GenerativeModel(
    model_name=MODEL_NAME,
    generation_config=generation_config,
    safety_settings=safety_settings,
)


def construct_prompt(content):
    """
    Constructs the detailed prompt for Gemini.
    """
    prompt = (
        """
Analyze the following HPC batch script. Your task is to:
1.  Identify the original job manager (e.g., flux, slurm, pbs, torque, moab, kubernetes, lsg, htcondor,cobalt, sun grid engine, or "unknown" if truly unidentifiable).
2.  Identify the main application or command being executed (e.g., "./my_mpi_app", "gromacs", "python simulation.py").
3.  Summarize the key computational resources requested (e.g., nodes, cores/cpus, memory, GPUs, walltime).
4.  List any software modules loaded or significant environment setup commands (e.g., "module load gcc openmpi", "source /opt/app/env.sh").
5.  Derive a script complexity score (integer from 1 to 10, where 1 is very simple, 10 is very complex).
    Consider these factors for complexity:
    - Variety and specificity of resource requests (e.g., just nodes vs. nodes, cores, mem, gpus, specific features).
    - Use of advanced scheduler features (job arrays, dependencies, reservations, specific partitions/queues).
    - Presence of scripting logic within the job submission part (loops, conditionals directly influencing submission).
    - Number and type of software modules or environment configurations.
    - Length and intricacy of the actual command(s) being run.

Then, generate an equivalent batch script for the following target job manager: Flux.
Ensure resource requests are translated as accurately as possible to the Flux batch syntax. Please first provide a json structure with metadata including "job_manager", "application", "resources", "software", "complexity_score." Then put a clear "====================="  that we can split by, and write the new Flux script in plain text. 

Here is the batch script:

%s
"""
        % content
    )
    return prompt


def process_batch_script(filename, script_content):
    """
    Sends a batch script to Gemini for analysis and conversion, then parses the response.
    """
    prompt = construct_prompt(script_content)
    try:
        # It's good practice to handle potential API errors
        response = model.generate_content(prompt)
    except Exception as e:
        print(Fore.LIGHTRED_EX + str(e) + Style.RESET_ALL)
        return None, None

    # When it was too complex (and couldn't generate json) this came back empty
    if not response.parts:
        alert = f"👉 Response for {os.path.basename(filename)} has no parse"
        print(Fore.LIGHTRED_EX + alert + Style.RESET_ALL)
        if hasattr(response, "prompt_feedback") and response.prompt_feedback:
            print(f"  Prompt Feedback: {response.prompt_feedback}")
        return None, None

    # We got a response?
    response_text = response.text

    if not response_text:
        return None, None
    try:
        metadata, script = response_text.split("=====================")
    except:
        print(f"Issue splitting by delimiter: {response_text}")
        return {}, response_text

    print(
        Fore.LIGHTBLUE_EX
        + f"🎉 We have a response for {os.path.basename(filename)}!"
        + Style.RESET_ALL
    )

    # And for the bash script too
    script = script.strip()
    if script.startswith("```bash"):
        script = script.strip()[7:-3].strip()
    elif script.startswith("```"):
        script = script.strip()[3:-3].strip()
    elif script.startswith("```sh"):
        script = script.strip()[5:-3].strip()

    # Attempt to parse the JSON - it comes back as either markdown or code blocks
    metadata = metadata.strip()
    if metadata.startswith("```json"):
        metadata = metadata.strip()[7:-3].strip()
    elif metadata.startswith("```"):
        metadata = metadata.strip()[3:-3].strip()

    # Don't try json loading, we will do this with flux validate
    time.sleep(5)
    return metadata, script


def get_parser():
    parser = argparse.ArgumentParser(description="Gemini Jobspec Generator")
    parser.add_argument(
        "--input",
        help="Input directory",
        default=os.path.join(here, "data"),
    )
    parser.add_argument(
        "--limit",
        help="Max number to generate",
        default=100,
        type=int,
    )
    parser.add_argument(
        "--output",
        help="Output data directory",
        default=os.path.join(here, "results"),
    )
    return parser


def main():
    parser = get_parser()
    args, _ = parser.parse_known_args()
    if not GEMINI_API_KEY:
        sys.exit("Exiting due to missing API key.")

    if not os.path.exists(args.input):
        sys.exit("An input directory is required.")

    if not os.path.exists(args.output):
        os.makedirs(args.output)

    # Read in the jobspecs
    contenders = list(recursive_find(args.input))

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
    import IPython

    IPython.embed()
    sys.exit()

    count = 0
    total = args.limit
    for i, filename in enumerate(files):
        outfile = args.output + os.sep + os.path.relpath(filename, args.input)

        # If we are successful, we will save metadata and script
        outfile_meta = f"{outfile}-metadata.json"
        outfile_script = f"{outfile}-flux-batch.sh"

        # If we are not, save the response provided
        error_text = f"{outfile}-response-error.txt"

        # Did we already try this one?
        if os.path.exists(outfile_meta) or os.path.exists(error_text):
            continue
        print(
            Fore.LIGHTWHITE_EX
            + Back.GREEN
            + f"\nProcessing {i} of {total}"
            + Style.RESET_ALL
        )

        # Read script into string to process
        metadata, flux_script = process_batch_script(filename, read_file(filename))
        if not metadata and not flux_script:
            print(
                Fore.LIGHTRED_EX + f"Issue with {filename} no output" + Style.RESET_ALL
            )
            continue

        # Create output directory
        outdir = os.path.dirname(outfile)
        if not os.path.exists(outdir):
            os.makedirs(outdir)

        # If we don't get metadata we got a response, but probably not json.
        if not metadata:
            print(
                Fore.LIGHTRED_EX
                + f"Issue with {filename} needs check"
                + Style.RESET_ALL
            )
            write_file(flux_script, error_text)
            continue

        # Otherwise, we got a flux batch script and json
        write_file(flux_script, outfile_script)
        write_file(metadata, outfile_meta)

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
    import IPython

    IPython.embed()


if __name__ == "__main__":
    main()
