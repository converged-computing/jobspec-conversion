#!/bin/bash
#FLUX: --job-name=train_color_jiggle
#FLUX: -t=259200
#FLUX: --urgency=16

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
CONTENT_ROOT="$VSC_DATA/lib/curla"
LOG_DIR="$CONTENT_ROOT/logs"
if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
fi
IMAGE="$CARLA_ROOT/conda_carla.sif"
SCRIPT="$CONTENT_ROOT/train.py"
AUGMENTATION="color_jiggle"
LOG_OUT="$LOG_DIR/train_color_jiggle_$(date +%m-%d_%H-%M).out"
LOG_ERR="$LOG_DIR/train_color_jiggle_$(date +%m-%d_%H-%M).err"
echo "[MESSAGE] Starting apptainer run"
apptainer run --nv -B $VSC_HOME -B $VSC_DATA -B $VSC_SCRATCH "$IMAGE" "$SCRIPT" "--augmentation" "$AUGMENTATION" > "$LOG_OUT" 2> "$LOG_ERR"
echo "[MESSAGE] Finished apptainer run"
