#!/bin/bash
#FLUX: --job-name=siren
#FLUX: -c=10
#FLUX: -t=360000
#FLUX: --urgency=16

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.10.1 # pytorch-gpu/py3/1.5.0
dataset_name="burgers"
run_name="tough-puddle-24"
srun python3 -m training.create_modulations "functa.dataset_name=${dataset_name}" "functa.run_name=${run_name}"
