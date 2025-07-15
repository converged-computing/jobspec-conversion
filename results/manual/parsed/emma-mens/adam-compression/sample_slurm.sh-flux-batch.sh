#!/bin/bash
#FLUX: --job-name=/gscratch/stf/emazuh/adam-compression/sample_slurm.sh
#FLUX: -N=2
#FLUX: -c=12
#FLUX: --queue=ckpt
#FLUX: -t=14400
#FLUX: --priority=16

export PATH='$PATH:/mmfs1/home/emazuh/anaconda3/bin'

echo $SLURM_ARRAY_JOB_ID_$SLURM_ARRAY_TASK_ID
export PATH=$PATH:/mmfs1/home/emazuh/anaconda3/bin
echo $CONDA_DEFAULT_ENV
module load cuda
module load ompi
HOSTS_FLAG="-H "
for node in $(scontrol show hostnames "$SLURM_JOB_NODELIST"); do
   HOSTS_FLAG="$HOSTS_FLAG$node:$SLURM_NTASKS_PER_NODE,"
done
HOSTS_FLAG=${HOSTS_FLAG%?}
echo $HOSTS_FLAG
mpirun -np $SLURM_NTASKS $HOSTS_FLAG \
    -bind-to none -map-by slot -x NCCL_DEBUG=INFO \
    -x LD_LIBRARY_PATH -x PATH -mca pml ob1 \
    -mca btl ^openib -mca btl_tcp_if_exclude docker0,lo python train.py --configs configs/imagenet/resnet50.py configs/dgc/wm5.py configs/dgc/fp16.py configs/dgc/int32.py
