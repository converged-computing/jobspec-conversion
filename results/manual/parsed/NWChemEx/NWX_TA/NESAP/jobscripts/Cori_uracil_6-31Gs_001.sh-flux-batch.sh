#!/bin/bash
#FLUX: --job-name=cori_nwx_uracil_6-31gs_000020
#FLUX: --queue=regular
#FLUX: -t=1800
#FLUX: --urgency=16

export SCRATCH_DIR='$SCRATCH/$SLURM_JOB_NAME.$SLURM_JOB_ID'
export PERMANENT_DIR='$SCRATCH_DIR'
export OMP_NUM_THREADS='1'
export START_DIR='`pwd`'
export EXECUTABLE='`find .. -name Test_CCSD_T`'

export SCRATCH_DIR=$SCRATCH/$SLURM_JOB_NAME.$SLURM_JOB_ID
export PERMANENT_DIR=$SCRATCH_DIR
export OMP_NUM_THREADS=1
export START_DIR=`pwd`
module list
env | sort
pwd
export EXECUTABLE=`find .. -name Test_CCSD_T`
mkdir $SCRATCH_DIR
cp ../input/uracil.nwx                  $SCRATCH_DIR
cp $EXECUTABLE                          $SCRATCH_DIR
cd $SCRATCH_DIR
srun nvidia-smi
srun -n $SLURM_NPROCS ./Test_CCSD_T uracil.nwx
rm -rf $SCRATCH_DIR
