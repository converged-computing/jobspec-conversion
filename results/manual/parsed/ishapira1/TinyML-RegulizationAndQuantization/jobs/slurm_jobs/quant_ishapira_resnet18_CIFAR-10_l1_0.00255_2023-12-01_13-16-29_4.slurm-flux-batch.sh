#!/bin/bash
#FLUX: --job-name=goodbye-diablo-6374
#FLUX: --priority=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l1_0.00255_2023-12-01_13-16-29 --bit_width 4
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
