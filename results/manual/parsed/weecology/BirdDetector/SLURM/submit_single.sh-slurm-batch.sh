#!/bin/bash
#FLUX: --job-name=birddetector
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

sbatch <<EOT
ulimit -c 0
NCCL_DEBUG=INFO
source activate Zooniverse_pytorch
cd ~/BirdDetector/
module load git
git checkout $1
python single_run.py $3
EOT
