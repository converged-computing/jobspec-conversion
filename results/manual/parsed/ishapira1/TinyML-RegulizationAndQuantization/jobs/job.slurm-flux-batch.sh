#!/bin/bash
#FLUX: --job-name=sticky-despacito-9648
#FLUX: --queue=seas_gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/{PATH} --bit_width {bit_width}
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
