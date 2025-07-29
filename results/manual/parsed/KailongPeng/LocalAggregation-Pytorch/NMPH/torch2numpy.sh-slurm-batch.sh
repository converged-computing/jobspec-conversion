#!/bin/bash
#SBATCH --job-name=torch2numpy
#SBATCH --output=logs/%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=06:00:00

set -e
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36
python -u ./NMPH/torch2numpy.py
echo "done"
