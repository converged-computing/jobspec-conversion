#!/bin/bash
#FLUX: --job-name=rbatch_1
#FLUX: --queue=cpu
#FLUX: -t=172800
#FLUX: --urgency=16

number=$SLURM_ARRAY_TASK_ID
module load r/4.1.1-gcc-9.4.0-withx-rmath-standalone-python-3.8.12
Rscript 08_shearwaterML.R $number
