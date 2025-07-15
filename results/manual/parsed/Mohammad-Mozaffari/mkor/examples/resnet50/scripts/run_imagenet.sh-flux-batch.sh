#!/bin/bash
#FLUX: --job-name=rainbow-gato-1343
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

module load tacc-apptainer
export OMP_NUM_THREADS=8
OPTIMIZER=mkor
NPROC_PER_NODE=3
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
CMD="torch_imagenet_resnet.py --train-dir /tmp/imagenet/train/ --val-dir /tmp/imagenet/val/ --optimizer $OPTIMIZER --batch-size $BATCH_SIZE"
echo Copying ImageNet to /tmp
COPY_DATASET="tar -xf /work/07980/sli4/ls6/data/imagenet-1k.tar -C /tmp; mkdir /tmp/imagenet; mv /tmp/ILSVRC2012_img_train /tmp/imagenet/train; mv /tmp/ILSVRC2012_img_val /tmp/imagenet/val;"
RANK=0
for NODE in $RANKS; do
    LAUNCHER="singularity exec --bind $SCRATCH/resnet:$HOME --nv $SCRATCH/torch.sif torchrun --nproc_per_node=$NPROC_PER_NODE --nnodes=$NNODES --node_rank=$RANK --master_addr=$MAIN_RANK --master_port=1234"
    FULL_CMD="$COPY_DATASET $LAUNCHER $CMD"
    if [[ $NODE == $MAIN_RANK ]]; then
        echo $FULL_CMD
	    eval $FULL_CMD &
    else
        echo "Launching rank $RANK on remote node $NODE"
	ssh $NODE "bash -lc 'module load tacc-apptainer; export OMP_NUM_THREADS=8; $FULL_CMD'" &
    fi
    RANK=$((RANK + 1))
done
wait
