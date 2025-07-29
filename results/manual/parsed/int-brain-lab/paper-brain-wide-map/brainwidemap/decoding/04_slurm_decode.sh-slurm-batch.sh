#!/bin/bash
#SBATCH --job-name=decoding
#SBATCH --output=/scratch/users/bensonb/international-brain-lab/paper-brain-wide-map/brainwidemap/logs/slurm/dw_bwmapr_01_1_.%a.out
#SBATCH --error=/scratch/users/bensonb/international-brain-lab/paper-brain-wide-map/brainwidemap/logs/slurm/dw_bwmapr_01_1_.%a.err
#SBATCH --mail-user=bensonb@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --array=3301-3521

export PYTHONPATH='$PWD":$PYTHONPATH'

echo slurm_task $SLURM_ARRAY_TASK_ID
export PYTHONPATH="$PWD":$PYTHONPATH
echo
python 04_decode_single_session.py $SLURM_ARRAY_TASK_ID
