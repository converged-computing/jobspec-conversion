#!/bin/bash
#FLUX: --job-name=strawberry-lemur-9101
#FLUX: --urgency=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
echo "Start for rewind  Resnet"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --rewind --name Res_Short_Rewind1
echo "Start for rewind  Resnet2"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --rewind --name Res_Short_Rewind2
echo "Start for rewind  Resnet3"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --rewind --name Res_Short_Rewind3
deactivate
