#!/bin/bash
#FLUX: --job-name=tart-toaster-7402
#FLUX: --urgency=16

set -e
cd ..
source start_venv.sh
data="mpm-columns"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--ntraining_steps=1000000 \
--cuda_device_number=0 &
data="WaterDropSamplePytorch"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--ntraining_steps=1000000 \
--cuda_device_number=1
