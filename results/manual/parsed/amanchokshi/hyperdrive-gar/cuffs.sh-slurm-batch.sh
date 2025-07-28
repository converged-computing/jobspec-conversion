#!/bin/bash
#FLUX: --job-name=cuFFS
#FLUX: --queue=gpuq
#FLUX: -t=3600
#FLUX: --urgency=16

source /pawsey/mwa/software/python3/build_base.sh
module load cuda
module load hdf5
module load cfitsio
module use /astro/mwaeor/achokshi/software/modulefiles
module load cuFFS
CUFFS_IN=$1
time rmsynthesis $CUFFS_IN
rm $CUFFS_IN
