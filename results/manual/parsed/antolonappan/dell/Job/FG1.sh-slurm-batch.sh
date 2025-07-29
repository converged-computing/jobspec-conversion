#!/bin/bash
#SBATCH --job-name=FG1_LBIRD
#SBATCH --output=out/fg1.out
#SBATCH --error=out/fg1.err
#SBATCH --mail-user=anto.lonappan@sissa.it
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=32
#SBATCH --ntasks=500
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

export ini='LB_FG1.ini'

source /global/homes/l/lonappan/.bashrc
cd /global/u2/l/lonappan/workspace/dell
export ini=LB_FG1.ini
mpirun -np $SLURM_NTASKS python simulation.py $ini -fg
