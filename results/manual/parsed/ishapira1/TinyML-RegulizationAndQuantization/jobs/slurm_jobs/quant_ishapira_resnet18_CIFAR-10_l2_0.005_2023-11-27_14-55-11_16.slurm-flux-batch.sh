#!/bin/bash
#FLUX: --job-name=lovable-squidward-0559
#FLUX: --priority=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l2_0.005_2023-11-27_14-55-11 --bit_width 16
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
