#!/bin/bash
#FLUX: --job-name=Net2_Prune
#FLUX: -t=71940
#FLUX: --urgency=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
echo "Start IMP for Net2"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Net2 --batch-size 60 --epochs 30 --lr 2e-4 --dataset cifar10 --name Net2_IMP_Run1
echo "Starting SWA for Net2"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Net2 --batch-size 60 --epochs 30 --lr 2e-4 --dataset cifar10 --use-swa --name Net2SWARun1
echo "Starting 2nd SWA for Resnet"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --use-swa --name ResNet_SWARun2
deactivate
