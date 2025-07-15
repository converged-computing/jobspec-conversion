#!/bin/bash
#FLUX: --job-name=elmo
#FLUX: --queue=general --qos=short
#FLUX: -t=14400
#FLUX: --priority=16

module use /opt/insy/modulefiles
module load cuda/10.1 cudnn/10.1-7.6.0.64
source ~/NLP_project/Character-classification/venv/bin/activate
echo "Starting at $(date)"
srun python main.py
echo "Finished at $(date)"
