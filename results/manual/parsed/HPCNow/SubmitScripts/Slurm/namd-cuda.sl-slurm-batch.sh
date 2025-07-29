#!/bin/bash
#SBATCH --job-name=NAMD
#SBATCH --account=hpcnow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=2G
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='1'

module load NAMD/2.9
cp -pr /sNow/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
cp -pr $SCRATCH_DIR $HOME/OUT/namd
