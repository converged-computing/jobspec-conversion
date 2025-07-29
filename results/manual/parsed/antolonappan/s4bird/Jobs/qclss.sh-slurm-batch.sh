#!/bin/bash
#SBATCH --job-name=qclss
#SBATCH --output=out/qclss.out
#SBATCH --error=out/qclss.err
#SBATCH --mail-user=anto.lonappan@sissa.it
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=20
#SBATCH --ntasks=400
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

export ini='litebird1.ini'

source /global/homes/l/lonappan/.bashrc
conda activate PC2
cd /global/u2/l/lonappan/workspace/s4bird/s4bird
export ini=litebird1.ini
mpirun -np $SLURM_NTASKS python quest.py $ini -qclss
