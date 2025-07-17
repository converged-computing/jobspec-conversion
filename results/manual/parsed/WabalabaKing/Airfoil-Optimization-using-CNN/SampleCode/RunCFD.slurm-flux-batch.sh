#!/bin/bash
#FLUX: --job-name=C_A0
#FLUX: --queue=test
#FLUX: -t=14400
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/wz10/scratch/Deformed/RAE_Deform_1'

export SLURM_SUBMIT_DIR=/home/wz10/scratch/Deformed/RAE_Deform_1
cd $SLURM_SUBMIT_DIR
mpirun -n 14 SU2_DEF turb_RAE2822.cfg
