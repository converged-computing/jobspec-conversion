#!/bin/bash
#SBATCH --job-name=GCN
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:2
#SBATCH --mem-per-cpu=32768M
#SBATCH --time=06:00:00
#SBATCH --partition=batch

module load cuda/10.1.105
module load cudnn/7.5.0
module load nccl/2.4.8-cuda10.1
module load gcc/6.4.0
cd /ibex/scratch/feij/sparse_model/e2e-exps/GCN
/ibex/scratch/feij/envgpu/bin/mpirun --tag-output -x WANDB_PROJECT=e2e_exps -x WANDB_NAME=GCN -x WANDB_ENTITY=phlix  -x WANDB_API_KEY=3c748bd8c7fcc9d54534495a1d0a10b58bb3570e -x WANDB_TAGS=gcn_test -n 2 /ibex/scratch/feij/envgpu/bin/python train_sampling.py --data_name=ml-100k --gcn_agg_accum=stack --train_max_epoch 30 --train_lr 0.02 --use_one_hot_fea --gpu 0,1 --init tcp://127.0.0.1:33333
