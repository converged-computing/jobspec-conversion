#!/bin/bash
#FLUX: --job-name=fcn_r50_d8_Benchmark
#FLUX: -c=2
#FLUX: --queue=gpu,gpub
#FLUX: -t=604800
#FLUX: --urgency=16

cd ~/work/transformer-domain-generalization || return
module load comp/gcc/11.2.0
source activate transformer-domain-generalization
nvidia-smi
echo -e "Node: $(hostname)"
echo -e "Job internal GPU id(s): $CUDA_VISIBLE_DEVICES"
echo -e "Job external GPU id(s): ${SLURM_JOB_GPUS}"
srun python ./tools/benchmark.py local_configs/ResNet/50/fcn_r50-d8_512x1024_40k_cityscapes.py
