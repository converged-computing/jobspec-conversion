#!/bin/bash
#FLUX: --job-name=lisa_GEO
#FLUX: -n=8
#FLUX: --queue=serial_requeue
#FLUX: -t=480
#FLUX: --urgency=16

export PATH='/n/home08/cliffmeyer/Jingyu/miniconda3/bin:$PATH'

export PATH=/n/home08/cliffmeyer/Jingyu/miniconda3/bin:$PATH
source activate lisa_python3_env
cd /n/home08/cliffmeyer/projects/lisa/gene_num_sample_size
python run_combined.py -s "${SLURM_ARRAY_TASK_ID}" -n $1
