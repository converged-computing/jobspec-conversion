#!/bin/bash
#SBATCH --job-name=$experiment_notes_var
#SBATCH --account=akindiroglu
#SBATCH --output=/truba_scratch/akindiroglu/Slurm/output/out-%j.out
#SBATCH --error=/truba_scratch/akindiroglu/Slurm/error/err-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=palamut-cuda,barbun-cuda,akya-cuda

experiment_notes_var=bsign_default
module purge
module load centos7.3/lib/cuda/10.1
module load centos7.3/comp/gcc/6.4
/truba/home/akindiroglu/Workspace/Libs/pytorch_nightly/bin/python main.py \
 --model_type 'mc3_18' \
 --pretrained_model ''  \
 --num_workers 0 \
 --num_epochs 1000 \
 --input_size 128 \
 --batch_size = 64 \
 --dropout = 0.5 \
 --max_num_classes -1 \
 --iterations_per_epoch -1 \
 --display_batch_progress \
 --transfer_method 'single_target' \
 --transfer_train_source 'AUTSL_train_shared' \
 --transfer_train_target 'bsign22k_train_shared'\
 --transfer_validation 'bsign22k_val_shared'\
 --experiment_notes $experiment_notes_var
