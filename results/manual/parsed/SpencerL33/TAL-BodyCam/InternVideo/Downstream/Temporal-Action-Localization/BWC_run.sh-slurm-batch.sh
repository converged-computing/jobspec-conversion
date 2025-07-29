#!/bin/bash
#SBATCH --job-name=BWC
#SBATCH --account=def-panos
#SBATCH --output=out/log-%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=00:15:00

module load  StdEnv/2020  cuda cudnn
module load gcc opencv
nvidia-smi
source  ../../../ENV/bin/activate
echo "Testing..."
python -u ./train_eval.py ./configs/BWC.yaml --output BWC_out 2>&1 | tee BWC_out.log
