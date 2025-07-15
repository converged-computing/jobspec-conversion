#!/bin/bash
#FLUX: --job-name=install_carla_img
#FLUX: -t=7200
#FLUX: --priority=16

export APPTAINER_TMPDIR='$VSC_SCRATCH/apptainer/tmp'
export APPTAINER_CACHEDIR='$VSC_SCRATCH/apptainer/cache'

module --force purge
module use /apps/leuven/${VSC_ARCH_LOCAL}/2021a/modules/all
module load intel/2021a
module load libpng
module load libjpeg-turbo
module load CUDA
echo "nvcc --version:"
nvcc --version
echo "nvidia-smi:"
nvidia-smi
ssh-add ~/.ssh/id_ed25519
git pull
CARLA_ROOT="$VSC_DATA/lib/carla"
mkdir -p $CARLA_ROOT
export APPTAINER_TMPDIR="$VSC_SCRATCH/apptainer/tmp"
export APPTAINER_CACHEDIR="$VSC_SCRATCH/apptainer/cache"
mkdir -p $APPTAINER_TMPDIR
mkdir -p $APPTAINER_CACHEDIR
if [ -f $CARLA_ROOT/conda_carla.sif ]; then
  rm -f $CARLA_ROOT/conda_carla.sif
fi
apptainer build --nv "$CARLA_ROOT/conda_carla.sif" ./jobs/conda_carla.def
