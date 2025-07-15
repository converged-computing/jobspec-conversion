#!/bin/bash
#FLUX: --job-name=gassy-lettuce-1195
#FLUX: --urgency=16

export KMP_BLOCKTIME='0'
export KMP_AFFINITY='granularity=fine,compact,1,0'

module load tensorflow/intel-1.13.1-py36
export KMP_BLOCKTIME=0
export KMP_AFFINITY="granularity=fine,compact,1,0"
config=configs/cifar10_resnet.yaml
python -c "import keras; keras.datasets.cifar10.load_data()"
srun python train.py $config -d
