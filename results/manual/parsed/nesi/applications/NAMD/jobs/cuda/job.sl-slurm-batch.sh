#!/bin/bash
#SBATCH --job-name=GROMACS_JOB
#SBATCH --account=uoa99999
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=2048
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='1'

source /etc/profile
module load NAMD/2.9-sandybridge
cp -pr /share/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
cp -pr $SCRATCH_DIR $HOME/OUT/namd
