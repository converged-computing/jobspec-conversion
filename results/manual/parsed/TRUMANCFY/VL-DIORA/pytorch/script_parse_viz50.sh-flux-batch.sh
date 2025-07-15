#!/bin/bash
#FLUX: --job-name=wobbly-pot-1704
#FLUX: -c=5
#FLUX: --urgency=16

export MASTER_ADDR='0.0.0.0'
export MASTER_PORT='8088'
export NODE_RANK='0'
export PYTHONPATH='/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH'

export MASTER_ADDR="0.0.0.0"
export MASTER_PORT="8088"
export NODE_RANK=0
/bin/echo Running on host: `hostname`
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
/bin/echo SLURM_JOB_ID: $SLURM_JOB_IdD
set -o errexit
source /itet-stor/fencai/net_scratch/anaconda3/bin/activate diora
export PYTHONPATH=/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH
srun python diora/scripts/parse_viz.py \
    --batch_size 1 \
    --data_type viz \
    --emb resnet50 \
    --load_model_path ../log/569a1213/model.step_1000.pt \
    --model_flags ../log/569a1213/flags.json \
    --validation_path ./data/partit_data/3.bag/test \
    --validation_filter_length 20 \
    --word2idx './data/partit_data/partnet.dict.pkl' \
    --k_neg 5 \
    --freeze_model 1 \
    --cuda \
    --vision_type "bag"
echo finished at: `date`
exit 0;
