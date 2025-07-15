#!/bin/bash
#FLUX: --job-name=quirky-staircase-2196
#FLUX: --queue=all_usr_prod
#FLUX: -t=10800
#FLUX: --urgency=16

if test $(python3 get_last_epoch.py checkpoints/frcnn/checkpoint.pth) -ge 2
then
    python -u -m torch.distributed.run \
    --nproc_per_node=4 \
    --nnodes=${SLURM_NNODES} \
    --node_rank=${SLURM_NODEID} \
    --master_addr=$(hostname -s) \
    --master_port=12346 \
    train.py --config config.yaml --log_dir logs --model frcnn --verbose --resume_checkpoint checkpoints/frcnn/checkpoint.pth
else
    python -u -m torch.distributed.run \
    --nproc_per_node=4 \
    --nnodes=${SLURM_NNODES} \
    --node_rank=${SLURM_NODEID} \
    --master_addr=$(hostname -s) \
    --master_port=12346 \
    train.py --config config.yaml --log_dir logs --model frcnn --verbose
fi
python -u -m torch.distributed.run \
    --nproc_per_node=4 \
    --nnodes=${SLURM_NNODES} \
    --node_rank=${SLURM_NODEID} \
    --master_addr=$(hostname -s) \
    --master_port=12347 \
    evaluate.py --config ./config.yaml --model frcnn > logs/frcnn/test.log
