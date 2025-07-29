#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=11:59:00
#SBATCH --array=0-10%2

export DATA_DIR='$SLURM_TMPDIR/data'

set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o errtrace    # Show error trace
set -o pipefail   # Unveils hidden failures
module load anaconda/3
conda activate sequoia
cd ~/Sequoia
cp -r data $SLURM_TMPDIR/
export DATA_DIR=$SLURM_TMPDIR/data
/home/mila/n/normandf/.conda/envs/sequoia/bin/sequoia_sweep --data_dir $SLURM_TMPDIR/data "$@"
