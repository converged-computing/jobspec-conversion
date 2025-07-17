#!/bin/bash
#FLUX: --job-name=gearshifft-gtx1080
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

k=$SLURM_ARRAY_TASK_ID
CURDIR=${HOME}/development/gearshifft
RESULTSA=${CURDIR}/results/GTX1080/cuda-8.0.61
RESULTSB=${CURDIR}/results/GTX1080/clfft-2.12.2
FEXTENTS1D=$CURDIR/config/extents_1d_publication.conf
FEXTENTS2D=$CURDIR/config/extents_2d_publication.conf
FEXTENTS3D=$CURDIR/config/extents_3d_publication.conf
FEXTENTS=${CURDIR}/config/extents_capped_all_publication.conf
module load cuda/8.0.61 clfft/2.12.2 fftw/3.3.6-pl1-brdw boost/1.63.0
module unload gcc
module load gcc/5.3.0
if [ $k -eq 1 ]; then
    mkdir -p ${RESULTSA}
    srun $CURDIR/build-brdw/gearshifft_cufft -f $FEXTENTS -o $RESULTSA/cufft_gcc5.3.0_centos7.2.csv
fi
if [ $k -eq 2 ]; then
    mkdir -p ${RESULTSB}
    srun  $CURDIR/build-brdw/gearshifft_clfft -f $FEXTENTS -o $RESULTSB/clfft_gcc5.3.0_centos7.2.csv
fi
module list
nvidia-smi -q -d PERFORMANCE
