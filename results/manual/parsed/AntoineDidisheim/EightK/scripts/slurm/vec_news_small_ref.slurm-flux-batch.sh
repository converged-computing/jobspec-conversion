#!/bin/bash
#FLUX: --job-name="vec_news_ref_"
#FLUX: -c=4
#FLUX: --queue=cascade
#FLUX: -t=86400
#FLUX: --priority=16

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0-deeplearn
module load OpenMPI/4.1.4; module load PyTorch/1.12.1-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 vec_main.py ${SLURM_ARRAY_TASK_ID} --legal=0 --eight=0 --news=1 --ref=1 --bow=0 --small=1
