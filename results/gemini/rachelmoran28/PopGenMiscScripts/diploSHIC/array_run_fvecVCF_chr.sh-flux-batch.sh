#!/bin/bash
#
# Flux equivalent script for a single task of a job array.
# This script is intended to be launched using `flux bulksubmit`.
#
# Original Slurm directives:
# #SBATCH -p  small,amdsmall  (Note: Partitions/queues need site-specific mapping in Flux)
# #SBATCH --nodes=1
# #SBATCH --ntasks-per-node=1
# #SBATCH --cpus-per-task=1
# #SBATCH --mem=62gb
# #SBATCH -t 2:00:00
# #SBATCH -J fvecVCF
# #SBATCH --array=0-26
#
# Corresponding Flux options for each task in the bulk submission:
# flux: -N 1                    # Number of nodes per task
# flux: -n 1                    # Number of tasks (processes) per task job (should be 1 here)
# flux: -c 1                    # Number of CPUs per task (process)
# flux: --requires=mem=62G      # Memory per task
# flux: -t 2h                   # Walltime (2 hours)

# How to submit as a job array in Flux:
# flux mini bulksubmit --ntasks=27 \
#                      --job-name=fvecVCF \
#                      --tasks-per-job=1 \
#                      --nodes-per-job=1 \
#                      --cores-per-task=1 \
#                      --gpus-per-task=0 \
#                      --mem-per-task=62G \
#                      --walltime=2h \
#                      ./this_flux_script.sh
#
# Note on partitions/queues: The Slurm partition "-p small,amdsmall"
# needs to be mapped to your Flux environment. This might involve
# submitting to a specific Flux queue (e.g., `flux mini bulksubmit -q queuename ...`)
# or using resource constraints via `--requires` if 'small' or 'amdsmall'
# refer to specific hardware features.

# Environment setup
source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo

# Change to working directory
cd /home/mcgaughs/shared/Software/diploSHIC

# Variables from original script (may be used by commands in CMD_LIST)
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/filtered_snps/HardFilteredSNPs_250Samples"
Pop="Tinaja"

CMD_LIST="HardFiltered_All_Commands_fvecVCF.txt"

# In Slurm, SLURM_ARRAY_TASK_ID was 0-indexed (for array 0-26).
# In Flux, FLUX_TASK_RANK is also 0-indexed for tasks in a bulk submission.
# The `sed` command typically uses 1-based line numbers.
# We assume the original script intended to map the 0-indexed ID to 1-based lines.
TASK_LINE_NUMBER=$((FLUX_TASK_RANK + 1))

# Fetch the command for the current task
CMD="$(sed "${TASK_LINE_NUMBER}q;d" ${CMD_LIST})"

# Execute the command
eval ${CMD}