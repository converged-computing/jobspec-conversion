#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:h100:1
#SBATCH --mem=82G
#SBATCH --time=08:00:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu

PROJECT_ROOT="${SLURM_SUBMIT_DIR}/../.."
APPTAINER_IMAGE_PATH=${PROJECT_ROOT}/flamegpu2-circles-benchmark-11.8.sif
cd $PROJECT_ROOT
mkdir -p apptainer-workdir-h100 && cd apptainer-workdir-h100
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
apptainer exec --nv --cleanenv ${APPTAINER_IMAGE_PATH} /opt/FLAMEGPU2-circles-benchmark/build/bin/Release/circles-benchmark
