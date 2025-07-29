#!/bin/bash
#SBATCH --job-name=atac-run
#SBATCH --account=CHIARUGI-SL2-CPU
#SBATCH --mail-user=sa941@medschl.cam.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000mb
#SBATCH --time=1-12:00:00
#SBATCH --partition=skylake

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load default-impi                   # REQUIRED - loads the basic environment
module load samtools-1.4-gcc-5.4.0-derfxbk
application=""
options=""
:
conda activate py37
snakemake -j10 
