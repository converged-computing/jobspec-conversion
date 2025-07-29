#!/bin/bash
#FLUX: --job-name=3dresnet
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='/scratch/vihps/vihps14/env/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/scratch/vihps/vihps14/env/lib/python3.9/site-packages:$PYTHONPATH
source ~/miniconda3/etc/profile.d/conda.sh
conda activate /scratch/vihps/vihps14/env/
cd ~/project/online-gesture-recognition-project/
srun python ./run/run_3dresnet.py
