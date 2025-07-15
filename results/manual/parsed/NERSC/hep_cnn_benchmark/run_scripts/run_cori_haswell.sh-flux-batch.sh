#!/bin/bash
#FLUX: --job-name=astute-toaster-2650
#FLUX: --priority=16

export PYTHONPATH='$PWD:$PYTHONPATH'

module load tensorflow/intel-1.8.0-py27
export PYTHONPATH=$PWD:$PYTHONPATH
NUM_PS=0
if [ ! -z ${SLURM_NNODES} ]; then
    if [ ${SLURM_NNODES} -ge 2 ]; then
	NUM_PS=1
    fi
    runcommand="srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 64 -u"
else
    SLURM_NNODES=1
    runcommand=""
fi
echo "Running training"
set -x
${runcommand} python scripts/hep_classifier_tf_train.py \
    --config=configs/cori_haswell_224.json \
    --num_tasks=${SLURM_NNODES} \
    --num_ps=${NUM_PS}
