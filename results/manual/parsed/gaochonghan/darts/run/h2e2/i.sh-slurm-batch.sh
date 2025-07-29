#!/bin/bash
#FLUX: --job-name=ai
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
source /home/LAB/gaoch/miniconda2/bin/activate base
conda activate gchmini
cd ../..
echo Python:
which python
export NCCL_IB_DISABLE=1
export MKL_THREADING_LAYER=GNU
export CUDA_HOME=/usr/local/cuda-10.2
srun python ./augment.py --name ai --dataset imagenet --batch_size 128 --epochs 2000 --genotype \
"Genotype(
    normal=[[('sep_conv_3x3', 0), ('dil_conv_5x5', 1)], [('skip_connect', 0), ('dil_conv_3x3', 2)], [('sep_conv_3x3', 1), ('skip_connect', 0)], [('sep_conv_3x3', 1), ('skip_connect', 0)]],
    normal_concat=range(2, 6),
    reduce=[[('max_pool_3x3', 0), ('max_pool_3x3', 1)], [('max_pool_3x3', 0), ('skip_connect', 2)], [('skip_connect', 3), ('max_pool_3x3', 0)], [('skip_connect', 2), ('max_pool_3x3', 0)]],
    reduce_concat=range(2, 6)
)"
