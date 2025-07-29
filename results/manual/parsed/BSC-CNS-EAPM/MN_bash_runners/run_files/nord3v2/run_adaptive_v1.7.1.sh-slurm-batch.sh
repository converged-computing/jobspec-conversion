#!/bin/bash
#SBATCH --job-name=PELE
#SBATCH --output=PELE.out
#SBATCH --error=PELE.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --qos=debug

module purge
module load anaconda
module load intel impi mkl boost cmake transfer bsc
eval "$(conda shell.bash hook)"
conda activate /gpfs/projects/bsc72/conda_envs/platform/1.6.3
python -m AdaptivePELE.adaptiveSampling adaptive.conf
