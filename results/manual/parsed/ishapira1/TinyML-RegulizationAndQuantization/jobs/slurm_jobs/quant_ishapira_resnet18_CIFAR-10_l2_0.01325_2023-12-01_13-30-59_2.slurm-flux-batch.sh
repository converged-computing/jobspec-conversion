#!/bin/bash
#FLUX: --job-name=crusty-motorcycle-7485
#FLUX: --priority=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l2_0.01325_2023-12-01_13-30-59 --bit_width 2
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
