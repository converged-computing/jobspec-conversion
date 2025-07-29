#!/bin/bash
#SBATCH --job-name=eval_unet_128
#SBATCH --output=eval_unet_128_%j.out
#SBATCH --error=eval_unet_128_%j.err
#SBATCH --mail-user=seungwook.han@ibm.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=500g
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

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
python src/eval_unet_128_256.py \
--train_dir /data/ImageNet/ILSVRC2012/train/ --valid_dir /data/ImageNet/ILSVRC2012/val/ \
--batch_size 100 --image_size 256 \
--output_dir $HOME2/wtvae/results/unet_128_256_real_eval_day1/ \
--project_name unet_full_imagenet_128_256_eval \
--model_128_weights $HOME2/wtvae/results/unet_128_run1_3/iwt_model_128_itr98500.pth \
--model_256_weights $HOME2/wtvae/results/unet_256_real/iwt_model_256_itr78000.pth \
echo "Run completed at:- "
date
