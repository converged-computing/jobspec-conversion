#!/bin/bash
#SBATCH --job-name=cifar-resnet
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=knl

export KMP_BLOCKTIME='0'
export KMP_AFFINITY='granularity=fine,compact,1,0'

module load tensorflow/intel-1.13.1-py36
export KMP_BLOCKTIME=0
export KMP_AFFINITY="granularity=fine,compact,1,0"
config=configs/cifar10_resnet.yaml
python -c "import keras; keras.datasets.cifar10.load_data()"
srun python train.py $config -d
