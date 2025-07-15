#!/bin/bash
#FLUX: --job-name=rainbow-snack-7430
#FLUX: --priority=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 CIFAR_job.py --regularization_type {TYPE} --regularization_param {PARAM}
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
