#!/bin/bash
#FLUX: --job-name=cice-qc
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export HDF5_USE_FILE_LOCKING='FALSE'
export BASE='/lcrc/group/acme/ac.dcomeau/scratch/chrys/20221218.DMPAS-JRA1p5.TL319_EC30to60E2r2.chrysalis.column-package.intel/run'
export TEST='/lcrc/group/acme/ac.dcomeau/scratch/chrys/20221218.DMPAS-JRA1p5.TL319_EC30to60E2r2.chrysalis.icepack.intel/run'

cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
source /lcrc/soft/climate/e3sm-unified/load_latest_e3sm_unified_anvil.sh
export HDF5_USE_FILE_LOCKING=FALSE
export BASE=/lcrc/group/acme/ac.dcomeau/scratch/chrys/20221218.DMPAS-JRA1p5.TL319_EC30to60E2r2.chrysalis.column-package.intel/run
export TEST=/lcrc/group/acme/ac.dcomeau/scratch/chrys/20221218.DMPAS-JRA1p5.TL319_EC30to60E2r2.chrysalis.icepack.intel/run
srun -N 1 -n 1 python mpas-seaice.t-test.py $BASE $TEST
