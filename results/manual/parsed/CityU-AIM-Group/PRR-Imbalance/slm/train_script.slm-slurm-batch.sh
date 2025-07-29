#!/bin/bash
#SBATCH --job-name=train_script
#SBATCH --output=./experiment/train_script.out
#SBATCH --error=./experiment/train_script.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu1
#SBATCH --nodelist=node5

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
nvidia-smi
source /home/zchen72/.bashrc
conda activate fedenvs
python ./main.py \
--iters 50 \
--wk_iters 5 \
--network vgg_nb \
--l_rate 0.7 \
--save_path ./experiment/ \
--lr 1e-2 \
--proto_type fc \
--global_proto_type gaussian \
--tau 3.0 \
--theme train_script ;
