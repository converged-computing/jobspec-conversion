#!/bin/bash
#FLUX: --job-name=fuzzy-cinnamonbun-8671
#FLUX: -c=7
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load apptainer
apptainer run --nv ~/pytorch-1.8.1.sif main.py 
