#!/bin/bash
#FLUX: --job-name=buttery-toaster-6235
#FLUX: --urgency=16

OPTIMIZER=sgd
NPROC_PER_NODE=4
TRAIN_DIR=/scratch/m/mmehride/mozaffar/imagenet/ILSVRC2012_img_train
VAL_DIR=/scratch/m/mmehride/mozaffar/imagenet/ILSVRC2012_img_val
cd ../
if [[ -z "${NODEFILE}" ]]; then
    if [[ -n "${SLURM_NODELIST}" ]]; then
        NODEFILE=/tmp/imagenet_slurm_nodelist
        scontrol show hostnames $SLURM_NODELIST > $NODEFILE
    elif [[ -n "${COBALT_NODEFILE}" ]]; then
        NODEFILE=$COBALT_NODEFILE
    fi
fi
if [[ -z "${NODEFILE}" ]]; then
    MAIN_RANK=$HOSTNAME
    RANKS=$HOSTNAME
    NNODES=1
else
    MAIN_RANK=$(head -n 1 $NODEFILE)
    RANKS=$(tr '\n' ' ' < $NODEFILE)
    NNODES=$(< $NODEFILE wc -l)
fi
BATCH_SIZE=$((2048 / $NNODES / $NPROC_PER_NODE))
if [ "$BATCH_SIZE" -gt 512 ]; then
    BATCH_SIZE=512
fi
BASE_LR=0.0125
WEIGHT_DECAY=5e-5
DECAY_RATE=0.5
CMD="torch_imagenet_resnet.py --train-dir $TRAIN_DIR --val-dir $VAL_DIR --optimizer $OPTIMIZER --batch-size $BATCH_SIZE --base-lr $BASE_LR --weight-decay $WEIGHT_DECAY --lr-decay-rate $DECAY_RATE --log-dir logs/lr${BASE_LR}_wde${WEIGHT_DECAY}_decayrate$DECAY_RATE"
echo $CMD
CURRENT_DIR=$(pwd)
LOAD="module load anaconda3; source activate pytorch; export OMP_NUM_THREADS=8; cd $CURRENT_DIR;"
RANK=0
for NODE in $RANKS; do
    LAUNCHER="torchrun --nproc_per_node=$NPROC_PER_NODE --nnodes=$NNODES --node_rank=$RANK --master_addr=$MAIN_RANK --master_port=1234"
    FULL_CMD="$LOAD $LAUNCHER $CMD"
    if [[ $NODE == $MAIN_RANK ]]; then
        echo $FULL_CMD
	    eval $FULL_CMD &
    else
        echo "Launching rank $RANK on remote node $NODE"
	    ssh $NODE "bash -lc '$FULL_CMD'" &
    fi
    RANK=$((RANK + 1))
done
wait
