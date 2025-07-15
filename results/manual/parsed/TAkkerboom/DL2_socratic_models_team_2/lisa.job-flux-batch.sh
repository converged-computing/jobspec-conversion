#!/bin/bash
#FLUX: --job-name=Socrat
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate socrat
srun python -u main.py --data_dir $TMPDIR/ --lm 'google/flan-t5-xl'
