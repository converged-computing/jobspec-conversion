#!/bin/bash
#FLUX: --job-name=RobustNet+r101.sh_Benchmark
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
srun python ./tools/benchmark.py local_configs/ResNet/101/RobustNetR101.b5.512x512.gta2cs.40k.batch2.py
