#!/bin/bash
#SBATCH --job-name=hpo-cifar-cnn
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=knl

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
