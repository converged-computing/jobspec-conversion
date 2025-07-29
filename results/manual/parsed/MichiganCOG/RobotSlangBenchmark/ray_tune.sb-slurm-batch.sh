#!/bin/bash
#SBATCH --output=slurm_logs/%j.txt
#SBATCH --mail-user=shurjo@umich.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --gres=gpu:10
#SBATCH --time=7-00:00:00

echo $CUDA_VISIBLE_DEVICES
echo $HOSTNAME
wandb login 3be59e86854e7deac9e39bf127723eb2e4bf834d
cd $SLURM_SUBMIT_DIR
PYTHONPATH=""
source new_env/bin/activate
ulimit -n 50000
python train_raytune.py
