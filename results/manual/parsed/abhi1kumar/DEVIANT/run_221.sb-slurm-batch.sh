#!/bin/bash
#SBATCH --job-name=run_221
#SBATCH --output=./slurm_log/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=4G
#SBATCH --time=10:00:00

cd /mnt/home/kumarab6/project/DEVIANT/code ### change to the directory where your code is located
conda activate DEVIANT ### Activate virtual environment
srun /mnt/home/kumarab6/anaconda3/envs/DEVIANT/bin/python -u tools/train_val.py --config=experiments/run_221.yaml ### Run python code
scontrol show job $SLURM_JOB_ID ### write job information to output file
