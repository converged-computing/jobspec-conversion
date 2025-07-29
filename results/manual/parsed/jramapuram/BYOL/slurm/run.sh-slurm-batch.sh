#!/bin/bash
#FLUX: --job-name=SimCLR
#FLUX: -c=2
#FLUX: --queue=<MY_PARTITIONS_HERE>
#FLUX: -t=43200
#FLUX: --urgency=16

echo $CUDA_VISIBLE_DEVICES
module load GCCcore/8.2.0 Singularity/3.4.0-Go-1.12 CUDA/10.1.243     # load corresponding modules based on your cluster
MASTER=$(squeue | grep ${SLURM_ARRAY_JOB_ID}_0 | awk {'print $8'})    # job0 is the master
echo "master is $MASTER"
srun --unbuffered singularity exec -B <DATA_DIR>:/datasets \
     --nv $HOME/docker/pytorch1.5.0_cuda10.1.simg python ../main.py \
     --epochs=100 \
     --data-dir=/datasets \
     --batch-size=1024 \
     --convert-to-sync-bn \
     --visdom-url=http://MY_VISDOM_URL \
     --visdom-port=8097 \
     --num-replicas=16 \
     --distributed-master=$MASTER \
     --distributed-port=29301 \
     --distributed-rank=${SLURM_ARRAY_TASK_ID} \
     --uid=simclrv00_0
