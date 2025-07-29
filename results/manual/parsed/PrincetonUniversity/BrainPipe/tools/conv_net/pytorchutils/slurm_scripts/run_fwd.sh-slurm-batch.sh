#!/bin/bash
#SBATCH --output=/tigress/ahoag/cnn/exp2/slurm_logs/cnn_inf_%j.out
#SBATCH --error=/tigress/ahoag/cnn/exp2/slurm_logs/cnn_inf_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=5000
#SBATCH --time=00:10:00
#SBATCH --partition=all
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/2020.11
. activate brainpipe
python run_fwd.py exp2 /tigress/ahoag/cnn/exp2 models/RSUNet.py 12000 --gpus 0 --noeval --tag exp2
