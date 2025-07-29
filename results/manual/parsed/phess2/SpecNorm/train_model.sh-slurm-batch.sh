#!/bin/bash
#SBATCH --job-name=train_spec_norm
#SBATCH --output=outLogs/train_model_%A_%a.out
#SBATCH --error=outLogs/train_model_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=100Gb
#SBATCH --time=1-00:00:00
#SBATCH --array=0-11

source /etc/profile.d/modules.sh
module use /cm/shared/modulefiles
module add openmind/miniconda
source activate /om/user/rphess/conda_envs/pytorch_2_tv
which python3
python3 train.py --job_id $SLURM_ARRAY_TASK_ID \
                 --gpus 4 --num_workers 5 \
