#!/bin/bash
#FLUX: --job-name=preproc-fourcastnet
#FLUX: -t=36000
#FLUX: --priority=16

export N_WORKERS='32'
export N_THREADS_PER='2'
export HDF5_USE_FILE_LOCKING='FALSE'

export N_WORKERS=32
export N_THREADS_PER=2
export HDF5_USE_FILE_LOCKING='FALSE'
SCRIPT_DIR=$PWD
cd $SCRATCH
mkdir -p $SCRATCH/tmp
mkdir -p $SCRATCH/data/era5/fourcastnet
lfs setstripe -c 8 $SCRATCH/data/era5/fourcastnet
module load python
source activate mjonet-preproc
python -u $SCRIPT_DIR/04-preproc-fourcastnet.py
