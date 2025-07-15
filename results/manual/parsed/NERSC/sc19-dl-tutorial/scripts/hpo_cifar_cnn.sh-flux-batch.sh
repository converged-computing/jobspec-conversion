#!/bin/bash
#FLUX: --job-name=butterscotch-platanos-5978
#FLUX: --priority=16

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
