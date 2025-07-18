#!/bin/bash
#FLUX: --job-name=mutlisupcontrast_contr
#FLUX: -c=4
#FLUX: --queue=tesla
#FLUX: -t=90000
#FLUX: --urgency=16

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
DATASET_PATH="/home/wolodja5/celeba"
EXPERIMENT_PATH="/home/wolodja5/results/experiments"
mkdir -p $EXPERIMENT_PATH
RUN_ID=0
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err --label singularity run --nv pytorch.sif \
    python -m  torch.distributed.launch --nproc_per_node=1 tmp/MultiSupContrast/main_contr.py \
    --data=$DATASET_PATH \
    --data-name=CELEBA \
    --model-name=tresnet_s \
    --num-classes=40 \
    --image-size=64 \
    --method=MultiSupCon \
    --temp=0.1 \
    --feat-dim=128 \
    --c_treshold=0.2 \
    --learning_rate=0.25 \
    --lr_decay_epochs="70,80,90" \
    --cosine \
    --batch-size=128 \
    --epochs=100 \
    --sync_bn=False \
    --workers=4 \
    --dump_path=$EXPERIMENT_PATH
    --run=$RUN_ID
