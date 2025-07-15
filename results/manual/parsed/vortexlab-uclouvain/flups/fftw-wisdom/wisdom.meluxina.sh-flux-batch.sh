#!/bin/bash
#FLUX: --job-name=loopy-mango-6713
#FLUX: --queue=cpu
#FLUX: -t=43200
#FLUX: --priority=16

module purge
module use /apps/USE/easybuild/staging/2021.1/modules/all
module load FFTW/3.3.10-gompi-2021a
module list
WISDOM_DIR=${HOME}/flups/fftw-wisdom/wisdom
mkdir -p ${WISDOM_DIR}
fftw-wisdom -v -c -o ${WISDOM_DIR}/meluxina.wsdm -t 10
