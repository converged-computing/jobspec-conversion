#!/bin/bash
#FLUX: --job-name=ExampleJob
#FLUX: -c=6
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=5400
#FLUX: --urgency=16

cd $HOME/ATCS/group_assignment
source activate python385
srun python -u classify_emotion.py
