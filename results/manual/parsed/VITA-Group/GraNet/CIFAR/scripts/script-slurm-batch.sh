#!/bin/bash
#SBATCH --job-name=GraNet-cifar10-80epochs
#SBATCH --account=test
#SBATCH --output=GraNet-cifar10-80epochs.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

source /public/data2/software/software/anaconda3/bin/activate
conda activate torch151               # 激活的虚拟环境名称
model=ResNet50
data=cifar10
final=80
for density in 0.1 0.05 0.02
do
  for seed in 18 19 20
  do
  python main.py --sparse --seed $seed --death-rate 0.5 --final-prune-epoch $final --optimizer sgd --method GraNet --sparse-init ERK --init-density 0.50 --final-density $density --update-frequency 1000  --l2 0.0005  --lr 0.1 --epochs 160 --model $model --data $data  --batch-size 128 --growth gradient --death magnitude --redistribution none
  done
done
model=vgg19
data=cifar10
final=80
for density in 0.1 0.05 0.02
do
  for seed in 18 19 20
  do
  python main.py --sparse --seed $seed --death-rate 0.5 --final-prune-epoch $final --optimizer sgd --method GraNet --sparse-init ERK --init-density 0.50 --final-density $density --update-frequency 1000  --l2 0.0005  --lr 0.1 --epochs 160 --model $model --data $data  --batch-size 128 --growth gradient --death magnitude --redistribution none
  done
done
source deactivate
