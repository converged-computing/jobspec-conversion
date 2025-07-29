#!/bin/bash
#SBATCH --job-name=rohib
#SBATCH --account=PSYC0002
#SBATCH --output=./results/zreports/res20-baseline-%A.out
#SBATCH --error=./results/zreports/res20-baseline-%A.err
#SBATCH --mail-user=rio.ohib@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64g
#SBATCH --time=5-03:20:00
#SBATCH --partition=qTRDGPUM

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main.py --arch resnet20 --batch-size 128 --epochs 200 --lr 0.1 --lr-drop 80 120 160 \
--exp-name resnet20/baseline
