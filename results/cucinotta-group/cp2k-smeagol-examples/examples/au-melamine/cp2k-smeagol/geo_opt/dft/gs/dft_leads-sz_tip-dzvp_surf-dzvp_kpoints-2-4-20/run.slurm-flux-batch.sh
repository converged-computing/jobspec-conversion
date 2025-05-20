#!/bin/bash
#FLUX: -N 8
#FLUX: --tasks-per-node=64
#FLUX: --cores-per-task=1
#FLUX: --gpus-per-task=0 
#FLUX: --mem=3125M       # 200GB per node / 64 tasks per node = 3.125GB/task = 3125MB/task
#FLUX: --walltime=00:30:00
#FLUX: --output=cp2k_job.out
#FLUX: --error=cp2k_job.err

# Assuming the job starts in the submission directory, similar to PBS_O_WORKDIR
# If not, one might need: cd $FLUX_SUBMIT_DIR

module purge

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

# The following file operations are replicated from the original script.
# Their logic, especially the second 'find' command, might be unintended
# as it could remove freshly copied input files if they don't contain "slurm"
# in their names.
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm  {} +
cp input/* .

# Define the CP2K executable path
# Default CP2K 2022.1 (from module, if needed, but overridden below)
# cp2k_module_path=/gpfs/easybuild/prod/software/CP2K/2022.1-foss-2022a/