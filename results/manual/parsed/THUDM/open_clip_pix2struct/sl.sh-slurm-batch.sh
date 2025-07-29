#!/bin/bash
#SBATCH --job-name=open_clip_crop2
#SBATCH --output=/zhangpai21/yzy/lightning_logs/256t576_zero_14/slurm_logs/slurm_yzy_%x_%j.out
#SBATCH --error=/zhangpai21/yzy/lightning_logs/256t576_zero_14/slurm_logs/slurm_yzy_%x_%j.err
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --gres=gpu:8
#SBATCH --partition=dev
#SBATCH --constraint=ntasks-per-node=8

export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='0'
export NCCL_NET_GDR_LEVEL='2'
export MASTER_PORT='12802'
export MASTER_ADDR='$master_addr'

source /zhangpai21/dm/.bashrc
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=0
export NCCL_NET_GDR_LEVEL=2
bash -c 'echo "started at `date` on `hostname`"'
echo SLURM_NODELIST:${SLURM_NODELIST}
export MASTER_PORT=12802
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
srun python src/training/main.py \
    --save-frequency 1 \
    --report-to tensorboard \
    --dataset-type "webdataset" \
    --precision amp \
    --train-data="1"  \
    --val-data="1"  \
    --warmup 10000 \
    --batch-size=32 \
    --epochs=100000 \
    --workers=8 \
    --customized-config "/zhangpai21/workspace/yzy/open_clip/open_clip_config_evalnobitfit.json" \
    --train-num-samples 10000000 \
    --dataset-resampled \
    --local-loss \
    --gather-with-grad \
    --logs "/zhangpai21/yzy/lightning_logs/" \
    --bitfit
