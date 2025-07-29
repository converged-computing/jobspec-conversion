#!/bin/bash
#SBATCH --account=HEP2016-1-4
#SBATCH --output=search_%j.out
#SBATCH --error=search_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:00:00

cat $0
ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml PyTorch/1.1.0-Python-3.7.2
pwd
source /home/erwulff/vpyenv/bin/activate
which python
python --version
echo "Starting grid search..."
python 001_train
echo "Grid search ended."
echo "End of job."
