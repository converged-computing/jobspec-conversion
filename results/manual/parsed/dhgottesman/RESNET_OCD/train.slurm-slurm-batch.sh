#!/bin/bash
#SBATCH --job-name=train_resnet
#SBATCH --output=/home/yandex/DL20222023a/gottesman3/RESNET_OCD/train_output/train_resnet.out
#SBATCH --error=/home/yandex/DL20222023a/gottesman3/RESNET_OCD/train_output/train_resnet.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=2
#SBATCH --mem=100000
#SBATCH --time=12:00:00
#SBATCH --partition=studentbatch

python run_func_OCD.py -e 0 -pb ./base_models/resnet20.pt -pc ./configs/train_resnet.json -pdtr ./data/cifar10 -pdts ./data/cifar10 -dt resnet -prc 0
