#!/bin/bash
#SBATCH --job-name=LMDZ_RUN
#SBATCH --output=lmdzrun-%j.out
#SBATCH --error=lmdzrun-%j.err
#SBATCH --mail-user=jessed@berkeley.edu
#SBATCH --mail-type=ALL,TIME_LIMIT_50
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

module swap PrgEnv-intel PrgEnv-gnu
cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
srun -n 24 ./gcm.e
