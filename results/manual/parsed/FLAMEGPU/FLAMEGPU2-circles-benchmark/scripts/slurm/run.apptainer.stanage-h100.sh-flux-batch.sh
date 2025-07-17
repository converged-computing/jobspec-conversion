#!/bin/bash
#FLUX: --job-name=boopy-onion-3217
#FLUX: -c=24
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

PROJECT_ROOT="${SLURM_SUBMIT_DIR}/../.."
APPTAINER_IMAGE_PATH=${PROJECT_ROOT}/flamegpu2-circles-benchmark-11.8.sif
cd $PROJECT_ROOT
mkdir -p apptainer-workdir-h100 && cd apptainer-workdir-h100
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
apptainer exec --nv --cleanenv ${APPTAINER_IMAGE_PATH} /opt/FLAMEGPU2-circles-benchmark/build/bin/Release/circles-benchmark
