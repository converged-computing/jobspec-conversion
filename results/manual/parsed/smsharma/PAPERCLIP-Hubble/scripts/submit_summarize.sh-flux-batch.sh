#!/bin/bash
#FLUX: --job-name=summarize_mixtral
#FLUX: --queue=iaifi_gpu_priority
#FLUX: -t=172800
#FLUX: --urgency=16

export TF_CPP_MIN_LOG_LEVEL='2'
export ENV='outlines'

export TF_CPP_MIN_LOG_LEVEL="2"
module load python/3.10.9-fasrc01
module load cuda/12.2.0-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.4-fasrc01
export ENV=outlines
mamba activate $ENV
alias pip=/n/holystore01/LABS/iaifi_lab/Users/smsharma/envs/$ENV/bin/pip
alias python=/n/holystore01/LABS/iaifi_lab/Users/smsharma/envs/$ENV/bin/python
alias jupyter=/n/holystore01/LABS/iaifi_lab/Users/smsharma/envs/$ENV/bin/jupyter
cd /n/holystore01/LABS/iaifi_lab/Users/smsharma/multimodal-data/
/n/holystore01/LABS/iaifi_lab/Users/smsharma/envs/$ENV/bin/python summarize.py --data_dir /n/holystore01/LABS/iaifi_lab/Users/smsharma/multimodal-data/data --observations_dir observations_v1 --save_filename summary_v2 --verbose
