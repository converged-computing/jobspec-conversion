#!/bin/bash
#FLUX: --job-name=moolicious-cherry-8309
#FLUX: -c=4
#FLUX: --queue=dell
#FLUX: --priority=16

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
srun python ./augment.py --name a10 --dataset cifar10 --batch_size 196 --epochs 2000 --genotype \
"Genotype(normal=[[('sep_conv_3x3', 0), ('dil_conv_3x3', 1)], [('skip_connect', 0), ('skip_connect', 1)], [('skip_connect', 0), ('dil_conv_3x3', 3)], [('skip_connect', 0), ('dil_conv_3x3', 1)]], normal_concat=range(2, 6), reduce=[[('max_pool_3x3', 0), ('skip_connect', 1)], [('avg_pool_3x3', 0), ('skip_connect', 2)], [('avg_pool_3x3', 0), ('skip_connect', 2)], [('avg_pool_3x3', 0), ('skip_connect', 3)]], reduce_concat=range(2, 6))"
