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
source ~/python_3.6.0/bin/activate
python -u ../scripts/MI03C_Predictions_merge.py $1 $2 && echo "PYTHON SCRIPT COMPLETED"
