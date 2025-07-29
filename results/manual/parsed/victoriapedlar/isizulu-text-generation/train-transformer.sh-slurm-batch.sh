#!/bin/bash
#SBATCH --job-name=transformer
#SBATCH --account=nlpgroup
#SBATCH --mail-user=PDLVIC001@myuct.ac.za
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100-4g-20gb:1
#SBATCH --time=2-00:00:00

export PYTHONPATH='$PYTHONPATH:`pwd`/scripts'

CUDA_VISIBLE_DEVICES=$(ncvd)
module load python/anaconda-python-3.7
module load software/TensorFlow-A100-GPU
start=$(date +%s)
echo "Starting script..."
export PYTHONPATH=$PYTHONPATH:`pwd`/scripts
python3 scripts/train_example.py
end=$(date +%s)
echo "Elapsed Time: $(($end-$start)) seconds"
