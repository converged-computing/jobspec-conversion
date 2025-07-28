#!/bin/bash
#FLUX: --job-name=stinky-puppy-9003
#FLUX: -t=1800
#FLUX: --urgency=16

echo PROJECT_DIR=${PROJECT_DIR}
cd ${PROJECT_DIR}
echo "Starting sorting . . . "
cd CPP/cmake-build-release
./SamplesSorter ${PROJECT_DIR}/plots/VorticityCorr.${M}.GPU.${RUN_ID}/Fdata.E.${T}.${SLURM_ARRAY_TASK_ID}.np
