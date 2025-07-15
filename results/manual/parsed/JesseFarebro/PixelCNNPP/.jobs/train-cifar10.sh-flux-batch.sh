#!/bin/bash
#FLUX: --job-name=hello-sundae-9503
#FLUX: -c=16
#FLUX: -t=600
#FLUX: --urgency=16

set -e; pushd ${SLURM_SUBMIT_DIR}
trap "{ popd; date; }" EXIT
pwd; hostname; nvidia-smi
module restore tf2; source ~/.venv/tf2/bin/activate
tensorboard --logdir=${SLURM_SUBMIT_DIR}/logdir --host 0.0.0.0 &
python3 main.py --config experiments/cifar10.gin multigpu
