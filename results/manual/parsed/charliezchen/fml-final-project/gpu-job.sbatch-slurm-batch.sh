#!/bin/bash
#SBATCH --job-name=cifar_trades
#SBATCH --output=logs/joint-baseline-final-%x-%j.out
#SBATCH --error=logs/joint-baseline-final-%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=12GB
#SBATCH --time=20:00:00

date
singularity exec --nv \
	    --overlay ~/zc2157/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
	    /bin/bash -c "
source /ext3/env.sh
python3 train_trades_cifar10.py --beta 6 --lam 0 --model-dir model-cifar-baseline-final
date
"
