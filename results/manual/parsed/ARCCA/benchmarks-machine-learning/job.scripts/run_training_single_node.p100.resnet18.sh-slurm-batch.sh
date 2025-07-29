#!/bin/bash
#SBATCH --job-name=resnet18.amp
#SBATCH --account=scw1001
#SBATCH --output=o.%x.%j
#SBATCH --error=e.%x.%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=1-00:00:00

set -eu
module purge
module load compiler/gnu/7
module load python/3.7.0
module load CUDA/10.2
module list
source /scratch/c.c1045890/dl.examples/pytorch/apex-venv/bin/activate
WORKDIR=/scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/outputs/$SLURM_JOB_ID
rm -rf $WORKDIR
mkdir -p $WORKDIR
code="main_amp.py"
cp $code $WORKDIR
cd $WORKDIR
time python3 -u -m torch.distributed.launch --nproc_per_node=2 $code \
    -a resnet18 \
    --batch-size 256 \
    --workers 8 \
    --epochs 3 \
    --print-freq 100 \
    --opt-level O1 \
    /scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/rawdata
