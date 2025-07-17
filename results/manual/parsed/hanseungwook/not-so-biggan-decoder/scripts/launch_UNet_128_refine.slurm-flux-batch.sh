#!/bin/bash
#FLUX: --job-name=unet_128_refine
#FLUX: --queue=sched_system_all
#FLUX: -t=86400
#FLUX: --urgency=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=wmlce-ea
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
python src/train_unet_128_refine.py \
--train_dir /data/ImageNet/ILSVRC2012/train/ --valid_dir /data/ImageNet/ILSVRC2012/val/ \
--batch_size 128 --image_size 256 --mask_dim 64 --lr 1e-4 \
--num_epochs 100 --output_dir $HOME2/wtvae/results/unet_128_refine_bigger_capacity/ \
--project_name unet_full_imagenet_128_refine \
--save_every 500 --valid_every 1000 --log_every 50 \
--model_128_weights $HOME2/wtvae/results/unet_128_run2/iwt_model_128_itr197000.pth
echo "Run completed at:- "
date
