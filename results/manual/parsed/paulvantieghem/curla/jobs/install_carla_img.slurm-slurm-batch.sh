#!/bin/bash
#SBATCH --job-name=install_carla_img
#SBATCH --output=install_carla_img.out
#SBATCH --error=install_carla_img.err
#SBATCH --mail-user=paul.vantieghemdetenberghe@student.kuleuven.be
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

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
