#!/bin/bash
#FLUX: --job-name=eccentric-salad-1234
#FLUX: -t=86400
#FLUX: --priority=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=ml_gpu
CONDA_ROOT=$HOME2/anaconda3
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
ulimit -s unlimited
export NODELIST=nodelist.$
srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " NGPUs per node:= " $SLURM_GPUS_PER_NODE 
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
export HOROVOD_GPU_ALLREDUCE=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_BROADCAST=MPI
export NCCL_DEBUG=DEBUG
echo " Running on multiple nodes and GPU devices"
echo ""
echo " Run started at:- "
date
python \
      /home/churwitz/dsvae_experiments/train_UNET_pixel.py \
      --train_dir=/data/ImageNet/ILSVRC2012/train/ \
      --valid_dir=/data/ImageNet/ILSVRC2012/val/ \
      --batch_size=64 \
      --image_size=128 \
      --low_resolution=64 \
      --workers=4 \
      --lr=1e-3 \
      --num_epochs=100 \
      --output_dir=$HOME2/UNET/results/mask_64_128/ \
      --project=UNET \
      --save_every=500 \
      --valid_every=1000 \
echo "Run completed at:- "
date
