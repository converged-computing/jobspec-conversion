#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=workq2
#FLUX: --urgency=16

module load herramientas/python/3.6
PATH=/home/mroldan/.conda/envs/carto/bin:$PATH
srun python plot_test.py
