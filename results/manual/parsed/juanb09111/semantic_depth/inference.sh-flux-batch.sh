#!/bin/bash
#FLUX: --job-name=lagosben
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=259140
#FLUX: --priority=16

export MASTER_ADDR='$(hostname)'

module load CUDA/9.0
source activate pynoptorch
ip1=`hostname -I | awk '{print $2}'`
echo $ip1
export MASTER_ADDR=$(hostname)
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
MODEL_NAME=$1
BATCH_SIZE=$2
CHECKPOINT=$3
CAT_JSON=$4
DST=$5
DS=$6
python inference.py --model_name=$MODEL_NAME --batch_size=$BATCH_SIZE --checkpoint=$CHECKPOINT --categories_json=$CAT_JSON --dst=$DST --data_source=$DS --nodes=1 --ngpus=1 --ip_adress $ip1 $SLURM_TASK_ARRAY_ID
