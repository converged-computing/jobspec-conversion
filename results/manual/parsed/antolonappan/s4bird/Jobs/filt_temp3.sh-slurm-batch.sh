#!/bin/bash
#SBATCH --job-name=FilteringPol1
#SBATCH --output=out/filt_pol1.out
#SBATCH --error=out/filt_pol1.err
#SBATCH --mail-user=anto.lonappan@sissa.it
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=100
#SBATCH --ntasks=1000
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --qos=regular
#SBATCH --constraint=haswell

export ini='cmbs4_3.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=cmbs4_3.ini
mpirun -np $SLURM_NTASKS python quest.py $ini -ivt
