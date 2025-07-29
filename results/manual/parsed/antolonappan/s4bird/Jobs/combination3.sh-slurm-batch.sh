#!/bin/bash
#SBATCH --job-name=combine3
#SBATCH --output=out/combination3.out
#SBATCH --error=out/combination3.err
#SBATCH --mail-user=anto.lonappan@sissa.it
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=64
#SBATCH --ntasks=1000
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

export ini='combination3.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=combination3.ini
mpirun -np $SLURM_NTASKS python combination.py $ini -comb
