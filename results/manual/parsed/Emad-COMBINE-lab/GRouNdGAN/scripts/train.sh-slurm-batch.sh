#!/bin/bash
#SBATCH --job-name=training
#SBATCH --account={your-PI}
#SBATCH --mail-user={your-email}
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=7-00:00:00

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source {VIRTUAL ENV ACTIVATE SCRIPT HERE}
cd {PROJECT DIR HERE}
tensorboard --logdir="{GAN OUTPUT DIR HERE}/TensorBoard" --host 0.0.0.0 --load_fast false &
python src/main.py --config {CONFIG_FILE_HERE} --train
