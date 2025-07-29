#!/bin/bash
#SBATCH --job-name=mistral16
#SBATCH --account=danielk_gpu
#SBATCH --output=Log-mistral16
#SBATCH --mail-user=xye23@jhu.edu
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=1-08:00:00
#SBATCH --constraint=ntasks-per-node=12

module load gcc/9.3.0
module load cuda/12.1.0
module load anaconda
source activate test
nvidia-smi -l 5 > gpu_usage-mistral16.log &
PID=$!
python code/t1.py -s S1 -mn mistral -mh mistralai/Mistral-7B-v0.1 -b 4
kill $PID
