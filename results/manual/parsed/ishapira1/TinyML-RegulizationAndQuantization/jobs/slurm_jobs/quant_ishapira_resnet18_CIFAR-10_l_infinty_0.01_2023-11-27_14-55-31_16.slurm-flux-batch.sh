#!/bin/bash
#FLUX: --job-name=gloopy-salad-4460
#FLUX: --queue=seas_gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l_infinty_0.01_2023-11-27_14-55-31 --bit_width 16
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
