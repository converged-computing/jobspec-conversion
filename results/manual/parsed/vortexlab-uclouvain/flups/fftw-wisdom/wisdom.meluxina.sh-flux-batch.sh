#!/bin/bash
#FLUX: --job-name=astute-snack-4268
#FLUX: --queue=cpu
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module use /apps/USE/easybuild/staging/2021.1/modules/all
module load FFTW/3.3.10-gompi-2021a
module list
WISDOM_DIR=${HOME}/flups/fftw-wisdom/wisdom
mkdir -p ${WISDOM_DIR}
fftw-wisdom -v -c -o ${WISDOM_DIR}/meluxina.wsdm -t 10
