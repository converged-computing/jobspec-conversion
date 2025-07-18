#!/bin/bash
#FLUX: --job-name=repeatmodeler_model
#FLUX: -c=30
#FLUX: --queue=general
#FLUX: --urgency=16

hostname
date
module load RepeatModeler/2.0.4
module load ninja/0.95 
REPDIR=../../results/02_mask_repeats
cd ${REPDIR}
REPDB=athaliana_db
RepeatModeler -threads 30 -database ${REPDB} -LTRStruct 
date
