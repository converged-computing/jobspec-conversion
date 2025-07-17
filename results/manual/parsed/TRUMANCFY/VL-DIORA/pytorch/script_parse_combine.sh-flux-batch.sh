#!/bin/bash
#FLUX: --job-name=hello-blackbean-2904
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
srun python diora/scripts/parse_combine.py \
    --batch_size 1 \
    --data_type partit \
    --emb resnet18 \
    --load_model_path ../log/53fd0a27/model.step_10400.pt \
    --model_flags ../log/53fd0a27/flags.json \
    --validation_path ./data/partit_data/3.bag/test \
    --validation_filter_length 20 \
    --word2idx './data/partit_data/partnet.dict.pkl' \
    --k_neg 5 \
    --freeze_model 1 \
    --cuda \
    --vision_type "bag" \
    --level_attn 1 \
    --diora_shared 0 \
    --mixture 1 \
    --txt2img 1 \
    --outside_attn 1
echo finished at: `date`
exit 0;
