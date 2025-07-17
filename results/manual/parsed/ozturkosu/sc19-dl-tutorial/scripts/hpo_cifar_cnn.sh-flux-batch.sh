#!/bin/bash
#FLUX: --job-name=hpo-cifar-cnn
#FLUX: -N=8
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export KMP_BLOCKTIME='0'
export KMP_AFFINITY='granularity=fine,compact,1,0'

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
export KMP_BLOCKTIME=0
export KMP_AFFINITY="granularity=fine,compact,1,0"
script=hpo_train.py
args="-N ${SLURM_JOB_NUM_NODES} --verbose"
python -c "import keras; keras.datasets.cifar10.load_data()"
python $script $args
