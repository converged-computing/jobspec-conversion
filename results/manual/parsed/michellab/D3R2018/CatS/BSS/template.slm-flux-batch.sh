#!/bin/bash
#FLUX: --job-name=NAME
#FLUX: -c=14
#FLUX: --queue=gpu
#FLUX: -t=360000
#FLUX: --priority=16

export SIRE_DONT_PHONEHOME='1'
export SIRE_SILENT_PHONEHOME='1'
export PATH='/usr/local/cuda-9.0/bin:$PATH'
export AMBERHOME='/mnt/shared/software/amber18'
export OPENMM_PLUGIN_DIR='/mnt/shared/software/sire.app/lib/plugins'
export JOB_DIR='$SLURM_SUBMIT_DIR'
export CUDA_VISIBLE_DEVICES='1,0'

export SIRE_DONT_PHONEHOME=1
export SIRE_SILENT_PHONEHOME=1
export PATH=/usr/local/cuda-9.0/bin:$PATH
export AMBERHOME=/mnt/shared/software/amber18
while [ ! -f /mnt/shared/software/gromacs/bin/GMXRC ]; do
    sleep 1s
done
source /mnt/shared/software/gromacs/bin/GMXRC
export OPENMM_PLUGIN_DIR=/mnt/shared/software/sire.app/lib/plugins
mkdir $SLURM_SUBMIT_DIR/$SLURM_JOB_ID
cd $SLURM_SUBMIT_DIR/$SLURM_JOB_ID
export JOB_DIR=$SLURM_SUBMIT_DIR
export CUDA_VISIBLE_DEVICES=0,1
time /mnt/shared/software/sire.app/bin/sire_python --ppn=1 $JOB_DIR/binding_freenrg.py LIG0 LIG1 &
export CUDA_VISIBLE_DEVICES=1,0
time /mnt/shared/software/sire.app/bin/sire_python --ppn=1 $JOB_DIR/binding_freenrg.py LIG1 LIG0
wait
