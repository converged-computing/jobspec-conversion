#!/bin/bash
#FLUX: --job-name=purple-hope-4066
#FLUX: -c=16
#FLUX: -t=600
#FLUX: --priority=16

set -e; pushd ${SLURM_SUBMIT_DIR}
trap "{ popd; date; }" EXIT
pwd; hostname; nvidia-smi
module restore tf2; source ~/.venv/tf2/bin/activate
tensorboard --logdir=${SLURM_SUBMIT_DIR}/logdir --host 0.0.0.0 &
python3 main.py --config experiments/mnist.gin multigpu
