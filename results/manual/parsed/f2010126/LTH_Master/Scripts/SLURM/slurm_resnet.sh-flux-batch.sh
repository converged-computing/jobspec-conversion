#!/bin/bash
#FLUX: --job-name=dinosaur-lemon-0903
#FLUX: --priority=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
echo "Start IMP for Resnet"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind1
echo "Start IMP for Resnet2"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind2
echo "Start IMP for Resnet3"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind3
deactivate
