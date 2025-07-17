#!/bin/bash
#FLUX: --job-name=Swa_Net2_Prune
#FLUX: -t=71940
#FLUX: --urgency=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Net2 --batch-size 60 --epochs 30 --lr 2e-4 --pruning-levels 20 --dataset cifar10 --name Net2SWARun1
deactivate
