#!/bin/bash
# Flux batch script

# Resources
# Flux uses a single resource specification.  We'll translate the Slurm requests.
# The Slurm partitions are difficult to translate directly, so we'll omit them.
# Flux will schedule based on available resources.

# Request 1 node with 1 core and 230GB of memory.
# Flux uses a single string for resource requests.
# The 'mem' specifier is in MB.
# The 'nproc' specifier is for number of processes.
# The 'time' specifier is in HH:MM:SS.

# Flux job name
#SBATCH -J fvecVCF

# Output and error files
# Flux uses standard output/error redirection.
# Flux does not have a direct equivalent to SBATCH output/error flags.
# We'll redirect manually.
> CMS_fvecVCF.out 2> CMS_fvecVCF.err

# Array job
# Flux uses a loop to handle array jobs.
# SLURM_ARRAY_TASK_ID is available as $FLUX_TASK_ID in Flux.

# Environment setup
source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo

# Change directory
cd /home/mcgaughs/shared/Software/diploSHIC

# Set VCF and Pop variables
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/combined_filtered/250_samples"
Pop="CabMoroSurface"
CMD_LIST="HardFiltered_All_wInvar_Commands_fvecVCF_5kb.txt"

# Loop through array tasks
for i in $(seq 1001 2360); do
  # Get the command for the current task
  CMD=$(sed "${i}q;d" ${CMD_LIST})

  # Execute the command
  eval ${CMD}
done

# Walltime
# Flux uses the 'time' resource specifier.  This is set above.
# Flux will kill the job if it exceeds the specified time.