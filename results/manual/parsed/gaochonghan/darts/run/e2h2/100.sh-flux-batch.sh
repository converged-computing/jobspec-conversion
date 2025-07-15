#!/bin/bash
#FLUX: --job-name=fat-diablo-2384
#FLUX: -c=4
#FLUX: --queue=dell
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1'
export MKL_THREADING_LAYER='GNU'
export CUDA_HOME='/usr/local/cuda-10.2'

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo "$SLURM_JOB_NODELIST"
eval "$(conda shell.bash hook)"
source /home/LAB/anaconda3/bin/activate base
conda activate cpy
cd ../..
echo Python:
which python
export NCCL_IB_DISABLE=1
export MKL_THREADING_LAYER=GNU
export CUDA_HOME=/usr/local/cuda-10.2
srun python ./augment.py --name 2a100 --dataset cifar100 --batch_size 196 --epochs 2000 --genotype \
"Genotype(normal=[[('sep_conv_3x3', 1), ('sep_conv_3x3', 0)], [('dil_conv_3x3', 0), ('sep_conv_3x3', 1)], [('sep_conv_5x5', 1), ('sep_conv_3x3', 0)], [('sep_conv_5x5', 1), ('sep_conv_3x3', 0)]], normal_concat=range(2, 6), reduce=[[('skip_connect', 0), ('dil_conv_3x3', 1)], [('max_pool_3x3', 0), ('skip_connect', 2)], [('skip_connect', 2), ('max_pool_3x3', 0)], [('dil_conv_3x3', 3), ('dil_conv_5x5', 4)]], reduce_concat=range(2, 6))"
