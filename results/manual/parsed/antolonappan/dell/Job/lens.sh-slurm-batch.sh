#!/bin/bash
#SBATCH --job-name=Lensing
#SBATCH --output=out/lensing.out
#SBATCH --error=out/lensing.err
#SBATCH --mail-user=anto.lonappan@sissa.it
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=16
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

export ini='LB_FG2.ini'

source /global/homes/l/lonappan/.bashrc
conda activate cmblens
cd /global/u2/l/lonappan/workspace/LBlens
export ini=LB_FG2.ini
mpirun -np $SLURM_NTASKS python simulation.py $ini  -lens
