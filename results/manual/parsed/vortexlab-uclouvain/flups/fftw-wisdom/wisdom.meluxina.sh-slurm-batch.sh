#!/bin/bash
#SBATCH --account=p200053
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --qos=default

module purge
module use /apps/USE/easybuild/staging/2021.1/modules/all
module load FFTW/3.3.10-gompi-2021a
module list
WISDOM_DIR=${HOME}/flups/fftw-wisdom/wisdom
mkdir -p ${WISDOM_DIR}
fftw-wisdom -v -c -o ${WISDOM_DIR}/meluxina.wsdm -t 10
