#!/bin/bash
#FLUX: --job-name=hpo-cifar-cnn
#FLUX: -N=8
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

export KMP_BLOCKTIME='0'
export KMP_AFFINITY='granularity=fine,compact,1,0'

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
export KMP_BLOCKTIME=0
export KMP_AFFINITY="granularity=fine,compact,1,0"
script=hpo_train.py
args="-N ${SLURM_JOB_NUM_NODES} --verbose"
echo "python -c \"import keras; keras.datasets.cifar10.load_data()\""
python -c "import keras; keras.datasets.cifar10.load_data()"
echo "python -u $scripts $args"
python -u $script $args
