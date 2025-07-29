#!/bin/bash
#SBATCH --job-name=decoding
#SBATCH --output=/scratch/users/bensonb/international-brain-lab/paper-brain-wide-map/brainwidemap/logs/slurm/decodingformat.%A.%a.out
#SBATCH --error=/scratch/users/bensonb/international-brain-lab/paper-brain-wide-map/brainwidemap/logs/slurm/decodingformat.%A.%a.err
#SBATCH --mail-user=bensonb@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --array=1-50

export PYTHONPATH='$PWD":$PYTHONPATH'

echo index $SLURM_ARRAY_TASK_ID
export PYTHONPATH="$PWD":$PYTHONPATH
echo
python  05_format_results.py $SLURM_ARRAY_TASK_ID
