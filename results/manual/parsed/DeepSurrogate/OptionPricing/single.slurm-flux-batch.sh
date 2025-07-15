#!/bin/bash
#FLUX: --job-name=dr_default
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

module purge
module load my list of modules
module load cuda
nvidia-smi
module load gcc/9.3.0 python/3.8.8
source /work/FAC/HEC/DF/sscheid1/deep_replication/sq/venv/bin/activate
python3 /scratch/adidishe/fop/get_forecast.py
