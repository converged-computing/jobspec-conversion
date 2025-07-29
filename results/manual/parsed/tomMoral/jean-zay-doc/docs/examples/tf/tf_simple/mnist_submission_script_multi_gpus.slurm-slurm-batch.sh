#!/bin/bash
#FLUX: --job-name=tf_mnist_multi_gpus
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

set -x
cd ${SLURM_SUBMIT_DIR}
opt[0]=""
opt[1]=""
module purge
module load tensorflow-gpu/py3/2.1.0
srun python ./mnist_example.py ${opt[$SLURM_ARRAY_TASK_ID]}
wait
