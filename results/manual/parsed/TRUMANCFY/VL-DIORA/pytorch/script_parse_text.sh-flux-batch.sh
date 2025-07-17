#!/bin/bash
#FLUX: --job-name=astute-bike-2439
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
srun python diora/scripts/parse.py \
    --batch_size 10 \
    --data_type partit \
    --elmo_cache_dir data/elmo \
    --load_model_path ../log/b482bb14/model.step_4900.pt \
    --model_flags ../log/b482bb14/flags.json \
    --validation_path ./data/partit_data/1.table/test \
    --validation_filter_length 20 \
    --word2idx './data/partit_data/partnet.dict.pkl'
echo finished at: `date`
exit 0;
