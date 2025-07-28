#!/bin/bash
#FLUX: --job-name=test-learner
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load cuda/11.7
module load python/3.10
python -m ...
