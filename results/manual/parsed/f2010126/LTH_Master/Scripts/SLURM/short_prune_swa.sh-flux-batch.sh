#!/bin/bash
#FLUX: --job-name=ResNet_ShortPrune1
#FLUX: -t=71940
#FLUX: --urgency=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --use-swa --name ResNet_IMP_SWA1
deactivate
