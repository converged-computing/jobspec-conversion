#!/bin/bash
#SBATCH --output=slurm.%j
#SBATCH --mail-user=elbueler@alaska.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1

cd $SLURM_SUBMIT_DIR
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
make streams
rm ./nodes.$SLURM_JOB_ID
