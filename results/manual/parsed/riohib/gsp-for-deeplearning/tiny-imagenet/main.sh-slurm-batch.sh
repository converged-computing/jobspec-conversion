#!/bin/bash
#SBATCH --job-name=rohib
#SBATCH --account=PSYC0002
#SBATCH --output=./results/base_tiny_res18/res18-baseline-%A.out
#SBATCH --error=./results/base_tiny_res18/res18-baseline-%A.err
#SBATCH --mail-user=rio.ohib@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=64g
#SBATCH --time=5-03:20:00

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main_dali_gsp.py -a resnet18 --batch-size 256 --epochs 200 --exp-name base_tiny_res18 --lr 0.2 \
--lr-drop 100 150 --dataset tiny_imagenet /data/users2/rohib/datasets/tiny-imagenet-200
