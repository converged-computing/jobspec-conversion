#!/bin/bash
#FLUX: --job-name=expensive-knife-8678
#FLUX: --urgency=16

set -e
cd ..
source start_venv.sh
cd ..
python3 -m learning_to_simulate.render_rollout\
 --rollout_path="${WORK}/gns_tensorflow/Sand/rollouts/rollout_test_0.pkl"
