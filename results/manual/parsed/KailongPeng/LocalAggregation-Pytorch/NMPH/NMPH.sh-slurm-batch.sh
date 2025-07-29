#!/bin/bash
#SBATCH --job-name=NMPH
#SBATCH --output=logs/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=06:00:00

set -e
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36_jupyter  # py36_jupyter
python -u ./NMPH/NMPH.py "${SLURM_ARRAY_TASK_ID}"
echo "done"
