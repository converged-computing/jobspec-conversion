#!/bin/bash
#FLUX: --job-name=ips_fastran
#FLUX: -N=10
#FLUX: -c=64
#FLUX: --queue=regular
#FLUX: -t=172800
#FLUX: --urgency=16

export EFIT_BIN_DIR='/global/common/software/atom/cori/binaries/efit/default'
export EFIT_BIN_NAME='efitd90'

module load gcc
WORK_DIRECTORY=tokamak_design
rm -rf $SCRATCH/$WORK_DIRECTORY
mkdir $SCRATCH/$WORK_DIRECTORY
cp -rd * $SCRATCH/$WORK_DIRECTORY
cd $SCRATCH/$WORK_DIRECTORY
source activate /global/common/software/atom/cori/adaptive/conda
export EFIT_BIN_DIR=/global/common/software/atom/cori/binaries/efit/default
export EFIT_BIN_NAME=efitd90
ips.py --platform=platform.conf --simulation=ips.ml_train.config
wait
