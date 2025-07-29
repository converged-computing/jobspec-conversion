#!/bin/bash
#SBATCH --job-name=VGG_GNM
#SBATCH --output=logs/%A_%a.out
#SBATCH --error=logs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=05:00:00
#SBATCH --array=0-134

module purge
module load applications-extra
module load cudnn/7.0.3-cuda9.0.176
module load anaconda/2.1.0
source activate base
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
python main.py file -e $SLURM_ARRAY_TASK_ID
