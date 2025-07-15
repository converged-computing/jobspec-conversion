#!/bin/bash
#FLUX: --job-name=keras-mnist-gpu
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

declare -xr LOCAL_SCRATCH="/scratch/${USER}/${SLURM_JOB_ID}"
declare -xr LUSTRE_SCRATCH="/oasis/scratch/comet/mkandes/temp_project/singularity/images"
declare -xr SINGULARITY_MODULE='singularity/2.5.1'
module purge
module load gnu
module load mvapich2_ib
module load cmake
module load "${SINGULARITY_MODULE}"
module list
cp -rf ../../../comet-benchmark "${LOCAL_SCRATCH}"
cp "${LUSTRE_SCRATCH}/keras-tensorflow-gpu.img" "${LOCAL_SCRATCH}"
cd "${LOCAL_SCRATCH}/comet-benchmark/singularity/keras"
echo $(pwd)
singularity exec --nv ${LOCAL_SCRATCH}/keras-tensorflow-gpu.img python ./mnist_4_gpu.py
