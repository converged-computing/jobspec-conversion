#!/bin/bash
#FLUX: --job-name=CNN_Burn
#FLUX: -c=40
#FLUX: --queue=Nvidia
#FLUX: -t=21600
#FLUX: --urgency=16

module load tensorflow-gpu
RUNDIR=/storage02/43299_sp0039/burn_multi/
OUTDIR=/storage02/43299_sp0039/burn_multi/output
python ${RUNDIR}/GPU.py
python ${RUNDIR}/Model.py $RUNDIR
python ${RUNDIR}/Evaluation.py $RUNDIR $OUTDIR
