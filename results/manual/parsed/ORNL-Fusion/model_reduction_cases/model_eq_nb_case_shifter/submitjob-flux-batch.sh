#!/bin/bash
#FLUX: --job-name=ips_fastran
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load gcc
module load python
WORK_DIRECTORY=tokamak_design_nb_debug_shifter
rm -rf $SCRATCH/$WORK_DIRECTORY
mkdir $SCRATCH/$WORK_DIRECTORY
cp -rd * $SCRATCH/$WORK_DIRECTORY
cd $SCRATCH/$WORK_DIRECTORY
source activate /global/common/software/atom/cori/adaptive/conda
ips.py --platform=platform.conf --simulation=ips.ml_train.config
wait
