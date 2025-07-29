#!/bin/bash
#FLUX: --job-name=pyt_roll
#FLUX: --queue=rtx
#FLUX: -t=54000
#FLUX: --urgency=16

set -e
cd ..
source start_venv.sh
data="Sand-3D-modmeta"
python3 -m gns.train --mode="rollout" \
--data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--model_file="model-5000000.pt" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/"
