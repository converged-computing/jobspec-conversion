#!/bin/bash
#FLUX: --job-name=gouttham-LISA-export
#FLUX: -c=32
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

cd ~/$projects/projects/def-amahdavi/gna23/LISA/
source ./lisa_env/bin/activate
module load cuda/11.0
module use cuda/11.0
python chat.py --version='./runs/lisa-7b-xbd-14days/export/' --precision='bf16'
echo "Job finished with exit code $? at: `date`"
