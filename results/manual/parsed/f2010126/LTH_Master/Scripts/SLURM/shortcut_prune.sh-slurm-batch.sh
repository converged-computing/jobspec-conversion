#!/bin/bash
#SBATCH --job-name=ResNet_Short_Rewind
#SBATCH --output=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/resnet_rewind_short.out
#SBATCH --error=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/resnet_rewind_short.err
#SBATCH --mail-user=dipti.sengupta@students.uni-freiburg.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=19:59:00

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
