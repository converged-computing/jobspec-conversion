#!/bin/bash
#FLUX: --job-name=milky-citrus-8740
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

source trilinos-env-gpu.sh
cd build-gpu
cmake ..
make -j
srun ./tpetra_driver.x
