#!/bin/bash
#FLUX: --job-name=pusheena-peas-4156
#FLUX: --queue=seas_gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l2_0.04388_2023-12-01_13-16-19 --bit_width 8
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
