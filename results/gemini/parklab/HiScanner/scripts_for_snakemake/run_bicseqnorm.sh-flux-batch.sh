#!/bin/bash
#FLUX -n 8
#FLUX -t 12:00:00
#FLUX --requires=mem=16G
#FLUX --output=flux_%j.out
#
# Original Slurm directives not directly translated or requiring site-specific mapping:
# #SBATCH -p park                   # Slurm partition: In Flux, this might map to a queue (--queue=park)
#                                   # or specific resource requirements via --requires.
# #SBATCH -A park_contrib           # Slurm account: In Flux, this might be handled by project settings
#                                   # or specific flux submit options (e.g., --property=project=park_contrib).
# #SBATCH --mail-type=FAIL          # Mail notification: Flux handles job event notifications differently,
#                                   # typically via 'flux job attach' or event plugins, not simple directives.

# Load necessary software modules
# Ensure these modules are available in the Flux execution environment
module load gcc  conda2/4.2.13 bedtools gatk python/3.7.4 R/4.0.1
module load perl/5.30.0
module load samtools

# Script arguments passed from 'flux submit <script_name> <filepath_arg> <stem_arg>'
filepath=$1
stem=$2

# Basic argument check
if [ -z "$filepath" ] || [ -z "$stem" ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <filepath> <stem>"
    exit 1
fi

echo "Input filepath: $filepath"
echo "Input stem: $stem"

# Create output directories. The -p flag creates parent directories if they don't exist
# and doesn't error if the directory already exists.
mkdir -p "readpos/$stem/"
mkdir -p "temp/$stem/"
mkdir -p "bins/$stem/"

# Define configuration and temporary file paths based on the stem
config="cfg/$stem.cfg"
# Note: The original script defines 'temp' as "temp/$stem.tmp".
# This means a file named "$stem.tmp" directly inside the "temp/" directory,
# NOT inside the "temp/$stem/" directory. This behavior is preserved.
temp_file_for_norm="temp/$stem.tmp"


echo "Starting get_readpos step: extracting read positions"
# Loop through chromosomes/contigs to extract read positions in parallel.
# Each 'samtools view | perl' pipeline runs as a background job (&).
# These background jobs will share the 8 cores allocated by Flux.
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X; do
    echo "Processing chromosome/contig: $i"
    samtools view -q 30 -F 1284 "$filepath" "$i" | perl -ane 'print $F[3], "\n";' > "readpos/$stem/${i}.readpos.seq" &
done

# Wait for all background 'samtools view | perl' jobs to complete before proceeding
wait
echo "Finished get_readpos step."

echo "Starting bicseq-norm step"
# Check if the configuration file exists. The NBICseq-norm.pl script might require it.
if [ ! -f "$config" ]; then
    echo "Warning: Configuration file '$config' not found. NBICseq-norm.pl may fail or use default settings."
fi

# Execute the NBICseq-norm.pl script
# Ensure the path to NBICseq-norm.pl is correct and the script is executable.
/n/data1/hms/dbmi/park/yifan/tools/NBICseq-norm_v0.2.4/NBICseq-norm.pl -b=500000 --gc_bin -p=0.0002 "$config" "$temp_file_for_norm"
echo "Finished bicseq-norm step."

echo "Job completed successfully."