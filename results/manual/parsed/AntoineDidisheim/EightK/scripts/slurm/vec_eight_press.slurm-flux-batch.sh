#!/bin/bash
#FLUX: --job-name="vec_press"
#FLUX: -c=8
#FLUX: --queue=gpu-a100
#FLUX: -t=36000
#FLUX: --priority=16

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 vec_main.py ${SLURM_ARRAY_TASK_ID} --legal=0 --eight=1 --bow=1
