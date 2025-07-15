#!/bin/bash
#FLUX: --job-name=rainbow-hippo-1556
#FLUX: -c=5
#FLUX: --urgency=16

export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='8080'
export NODE_RANK='0'
export PYTHONPATH='/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH'

export MASTER_ADDR="127.0.0.1"
export MASTER_PORT="8080"
export NODE_RANK=0
/bin/echo Running on host: `hostname`
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
/bin/echo SLURM_JOB_ID: $SLURM_JOB_IdD
set -o errexit
source /itet-stor/fencai/net_scratch/anaconda3/bin/activate diora
export PYTHONPATH=/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH
srun python -m torch.distributed.launch diora/scripts/train_viz.py \
    --arch mlp-shared \
    --batch_size 16 \
    --data_type viz \
    --emb resnet50 \
    --hidden_dim 2048 \
    --log_every_batch 500 \
    --lr 1e-4 \
    --normalize unit \
    --reconstruct_mode softmax \
    --save_after 100 \
    --train_filter_length 20 \
    --train_path './data/partit_data/1.table/train' \
    --validation_path './data/partit_data/1.table/test' \
    --vision_type 'table' \
    --max_epoch 100 \
    --master_port 29502 \
    --word2idx './data/partit_data/partnet.dict.pkl' \
    --vocab_size 100 \
    --vision_pretrain_path '/itet-stor/fencai/net_scratch/VLGrammar/SCAN/outputs/partnet/table/scan/model-resnet50.pth.tar_64' \
    --freeze_model 1 \
    --save_distinct 500 \
    --cuda
echo finished at: `date`
exit 0;
