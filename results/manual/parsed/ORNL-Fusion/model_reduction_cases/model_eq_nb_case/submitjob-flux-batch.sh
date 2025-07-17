#!/bin/bash
#FLUX: --job-name=ips_fastran
#FLUX: -N=10
#FLUX: --queue=regular
#FLUX: -t=172800
#FLUX: --urgency=16

module load gcc
WORK_DIRECTORY=tokamak_design_nb
rm -rf $SCRATCH/$WORK_DIRECTORY
mkdir $SCRATCH/$WORK_DIRECTORY
cp -rd * $SCRATCH/$WORK_DIRECTORY
cd $SCRATCH/$WORK_DIRECTORY
source activate /global/common/software/atom/cori/adaptive/conda
ips.py --platform=platform.conf --simulation=ips.ml_train.config
wait
