#!/bin/bash
#FLUX: --job-name=pyt_render
#FLUX: --queue=rtx
#FLUX: -t=54000
#FLUX: --urgency=16

set -e
cd ..
source start_venv.sh
cd ..
python3 -m learning_to_simulate.render_rollout\
 --rollout_path="${WORK}/gns_tensorflow/Sand/rollouts/rollout_test_0.pkl"
