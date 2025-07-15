#!/bin/bash
#FLUX: --job-name=butterscotch-kerfuffle-0714
#FLUX: -c=10
#FLUX: --urgency=16

export TENSORPACK_PROGRESS_REFRESH='20'
export TENSORPACK_SERIALIZE='msgpack'

echo "NNODES: $SLURM_NNODES"
echo "JOBID: $SLURM_JOB_ID"
env | grep PATH
export TENSORPACK_PROGRESS_REFRESH=20
export TENSORPACK_SERIALIZE=msgpack
DATA_PATH=~/data/imagenet
BATCH=64
srun --output=logs/data-%J.%N.log \
		 --error=logs/data-%J.%N.err \
		 --gres=gpu:0 --cpus-per-task=60 --mincpus 60 \
	--ntasks=$SLURM_NNODES --ntasks-per-node=1 \
	python ./serve-data.py --data $DATA_PATH --batch $BATCH &
DATA_PID=$!
mpirun -output-filename logs/train-$SLURM_JOB_ID.log -tag-output \
	-bind-to none -map-by slot \
	-mca pml ob1 -mca btl_openib_receive_queues P,128,32:P,2048,32:P,12288,32:P,65536,32 \
	-x NCCL_IB_CUDA_SUPPORT=1 -x NCCL_IB_DISABLE=0 -x NCCL_DEBUG=INFO \
	python ./imagenet-resnet-horovod.py -d 50 \
    --data $DATA_PATH --batch $BATCH --validation distributed &
MPI_PID=$!
wait $MPI_PID
