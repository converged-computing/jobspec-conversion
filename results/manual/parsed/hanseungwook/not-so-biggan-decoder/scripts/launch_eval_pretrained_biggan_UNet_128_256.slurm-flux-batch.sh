#!/bin/bash
#FLUX: --job-name=psycho-leg-3114
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
python src/eval_pretrained_biggan_unet_128_256.py \
--batch_size 100 --image_size 256 \
--output_dir $HOME2/wtvae/results/pretrained_biggan_unet_128_256_eval_z04/ \
--project_name pretrained_biggan_unet_imagenet_128_256_eval \
--model_128_weights $HOME2/wtvae/results/unet_128_run2/iwt_model_128_itr197000.pth \
--model_256_weights $HOME2/wtvae/results/unet_256/iwt_model_256_itr220500.pth \
--sample_file $HOME2/pretrained_BigGAN/pretrained_samples.npz 
echo "Run completed at:- "
date
