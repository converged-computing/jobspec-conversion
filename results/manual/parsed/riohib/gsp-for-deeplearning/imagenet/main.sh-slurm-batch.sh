#!/bin/bash
#SBATCH --job-name=rohib
#SBATCH --account=PSYC0002
#SBATCH --output=./results/zreports/res50-S65-ft80-%A.out
#SBATCH --error=./results/zreports/res50-S65-ft80-%A.err
#SBATCH --mail-user=rio.ohib@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=64g
#SBATCH --time=5-03:20:00

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main_dali_gsp.py -a resnet50 --dist-url 'tcp://127.0.0.1:8801' --dist-backend 'nccl' \
--finetuning --gsp-training --resume-lr --batch-size 1024 --epochs 190 --exp-name gsp_S65_ft85_e20 \
--lr 0.0000004 --finetune-sps 0.85 --multiprocessing-distributed \
--world-size 1 --rank 0 /data/users2/rohib/github/imagenet-data \
--resume ./results/gsp_S65_ft85_e20/checkpoint.pth.tar
