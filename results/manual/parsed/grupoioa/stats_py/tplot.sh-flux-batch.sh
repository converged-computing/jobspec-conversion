#!/bin/bash
#FLUX: --job-name=boopy-platanos-3302
#FLUX: --priority=16

module load herramientas/python/3.6
PATH=/home/mroldan/.conda/envs/carto/bin:$PATH
srun python plot_test.py
