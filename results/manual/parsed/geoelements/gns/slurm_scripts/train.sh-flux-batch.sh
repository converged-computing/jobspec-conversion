#!/bin/bash
#FLUX: --job-name=red-cherry-0964
#FLUX: --urgency=16

set -e
cd ..
source start_venv.sh
data="Sand-3D"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--nsave_steps=10000 \
--cuda_device_number=0 \
--ntraining_steps=5000000 \
--model_file="latest" \
--train_state_file="latest"
