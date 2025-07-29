#!/bin/bash
#SBATCH --job-name=symb_class
#SBATCH --mail-user=wdlynch@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=3
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --time=694-10:39:00
#SBATCH --partition=high
#SBATCH: --exclusive
#SBATCH --array=0-20%1

export PATH='$GDIR/miniconda3/bin:$PATH'

GDIR=/group/hermangrp
export PATH=$GDIR/miniconda3/bin:$PATH
hosts=$(srun bash -c hostname)
source activate py37
python -m scoop --host $hosts -v sc.py $SLURM_ARRAY_TASK_ID
