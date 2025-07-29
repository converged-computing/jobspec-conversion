#!/bin/bash
#SBATCH --mail-user=alanlegoallec@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=priority

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI09E_GWAS_postprocessing.py $1 && echo "PYTHON SCRIPT COMPLETED"
