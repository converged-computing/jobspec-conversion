#!/bin/bash
#FLUX: --job-name=phat-gato-8444
#FLUX: --urgency=16

export PYTHONPATH='$PWD:$PYTHONPATH'

module load tensorflow/intel-1.8.0-py27
export PYTHONPATH=$PWD:$PYTHONPATH
if [ $SLURM_NNODES -ge 2 ]; then
    NUM_PS=1
    # Check if user specified more PS
    while getopts p: option
    do
	case "${option}"
	in
	p) NUM_PS=${OPTARG};;
	esac
    done
    if [ ${NUM_PS} -ge ${SLURM_NNODES} ]; then
	echo "The number of nodes has to be bigger than the number of parameters servers"
	exit
    fi
else
    NUM_PS=0
fi
set -x
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 272 -u \
    python ../scripts/hep_classifier_tf_train.py \
    --config=../configs/cori_knl_224_adam.json \
    --num_tasks=${SLURM_NNODES} \
    --num_ps=${NUM_PS}
