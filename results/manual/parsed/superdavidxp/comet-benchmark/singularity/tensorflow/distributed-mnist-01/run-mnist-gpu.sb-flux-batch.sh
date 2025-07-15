#!/bin/bash
#FLUX: --job-name="tensorflow-cifar10-gpu"
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --priority=16

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
cp "${LUSTRE_SCRATCH}/tensorflow-gpu.img" "${LOCAL_SCRATCH}"
cd "${LOCAL_SCRATCH}/comet-benchmark/singularity/tensorflow"
echo $(pwd)
singularity exec --nv ${LOCAL_SCRATCH}/tensorflow-gpu.img python ./multigpu_mnist.py
