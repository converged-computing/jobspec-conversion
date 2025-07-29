#!/bin/bash
#SBATCH --job-name=resnet50.amp.p100.container
#SBATCH --account=scw1001
#SBATCH --output=o.%x.%j
#SBATCH --error=e.%x.%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

set -eu
module purge
module load singularity
module list
IMAGEPATH=/scratch/c.c1045890/dl.examples/pytorch/nvidia.ngc.containers
IMAGENAME=pytorch-22.03-py3
WORKDIR=/scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/outputs/resnet50/$SLURM_JOB_ID
rm -rf $WORKDIR
mkdir -p $WORKDIR
code="main_amp.py"
cp $code $WORKDIR
cd $WORKDIR
singularity run --nv ${IMAGEPATH}/${IMAGENAME} python3 -u -m \
    torch.distributed.launch --nproc_per_node=2 $code \
    -a resnet50 \
    --batch-size 256 \
    --workers 8 \
    --epochs 3 \
    --print-freq 100 \
    --opt-level O1 \
    /scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/rawdata
