#!/bin/bash
#FLUX: --job-name=gearshifftK80
#FLUX: --exclusive
#FLUX: --queue=gpu2
#FLUX: -t=36000
#FLUX: --urgency=16

k=$SLURM_ARRAY_TASK_ID
CURDIR=$HOME/cuda-workspace/gearshifft
RESULTSA=$HOME/cuda-workspace/gearshifft_results/results/K80/cuda-8.0.61
RESULTSB=$HOME/cuda-workspace/gearshifft_results/results/K80/clfft-2.12.2
FEXTENTS=${CURDIR}/share/gearshifft/extents_capped_all_publication.conf
module purge
module load opencl boost/1.60.0-gnu5.3-intelmpi5.1 clFFT/2.12.2-cuda8.0-gcc5.3
module switch cuda/8.0.61
module unload mpirt
if [ $k -eq 1 ]; then
    mkdir -p ${RESULTSA}
    srun --cpu-freq=medium --gpufreq=2505:823 $CURDIR/release/gearshifft_cufft -f $FEXTENTS -o $RESULTSA/cufft_gcc5.3.0_RHEL6.8.csv
fi
if [ $k -eq 2 ]; then
    mkdir -p ${RESULTSB}
    srun --cpu-freq=medium --gpufreq=2505:823 $CURDIR/release/gearshifft_clfft -f $FEXTENTS -o $RESULTSB/clfft_gcc5.3.0_RHEL6.8.csv
fi
module list
nvidia-smi -q -d PERFORMANCE
