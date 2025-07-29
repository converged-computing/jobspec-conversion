#!/bin/bash
#FLUX: --job-name=extract_images
#FLUX: --queue=Nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load tensorflow-gpu
RUNDIR=/storage02/43299_sp0039/burn_multi
INDIR=/storage02/43299_sp0039/burn_multi/Burn_mod
python ${RUNDIR}/Data.py $INDIR $RUNDIR
