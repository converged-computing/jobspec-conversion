#!/bin/bash
#SBATCH --mail-user=kdb19
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuC

configName=$1
trainData=$2
evalData=$3
echo "Config " $configName
echo "Train Data " $trainData
echo "Eval Data " $evalData
source /homes/${USER}/.bashrc
conda activate dissertation
source /vol/cuda/11.0.3-cudnn8.0.5.39/setup.sh
/usr/bin/nvidia-smi
cd /vol/bitbucket/${USER}/document-classification-transformers
python main.py --config $configName --eval $evalData --train $trainData
