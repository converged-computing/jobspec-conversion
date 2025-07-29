#!/bin/bash
#SBATCH --job-name=Resnet_Rewind_All
#SBATCH --output=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/resnet_rewind.out
#SBATCH --error=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/resnet_rewind.err
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
echo "Start IMP for Resnet"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind1
echo "Start IMP for Resnet2"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind2
echo "Start IMP for Resnet3"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --pruning-levels 20 --dataset cifar10 --rewind --name ResnetRewind3
deactivate
