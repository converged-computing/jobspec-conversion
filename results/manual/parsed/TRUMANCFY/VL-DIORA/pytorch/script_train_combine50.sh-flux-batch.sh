#!/bin/bash
#FLUX: --job-name=delicious-cinnamonbun-3416
#FLUX: -c=5
#FLUX: --urgency=16

export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='8088'
export NODE_RANK='0'
export PYTHONPATH='/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH'

export MASTER_ADDR="127.0.0.1"
export MASTER_PORT="8088"
export NODE_RANK=0
/bin/echo Running on host: `hostname`
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
/bin/echo SLURM_JOB_ID: $SLURM_JOB_IdD
set -o errexit
source /itet-stor/fencai/net_scratch/anaconda3/bin/activate diora
export PYTHONPATH=/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH
srun python -m torch.distributed.launch --nproc_per_node=1 diora/scripts/train_combine.py \
    --arch mlp-shared \
    --batch_size 4 \
    --data_type partit \
    --elmo_cache_dir ./data/elmo \
    --emb combine50 \
    --hidden_dim 2048 \
    --k_neg 100 \
    --log_every_batch 100 \
    --reconstruct_mode softmax \
    --lr 2e-3 \
    --normalize unit \
    --save_after 500 \
    --train_path './data/partit_data/0.chair/train' \
    --validation_path './data/partit_data/0.chair/test' \
    --cuda \
    --max_epoch 100 \
    --master_port 29500 \
    --word2idx './data/partit_data/partnet.dict.pkl' \
    --vision_type 'chair' \
    --vision_pretrain_path '/itet-stor/fencai/net_scratch/VLGrammar/SCAN/outputs/partnet/chair/scan/model-resnet50.pth.tar_49' \
    --freeze_model 1 \
    --level_attn 0 \
    --diora_shared 0 \
    --mixture 1
echo finished at: `date`
exit 0;
