#!/bin/bash
#SBATCH --job-name=ResNet_ShortPrune1
#SBATCH --output=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/shortSWA_res1.out
#SBATCH --error=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/shortSWA_res1.err
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
python3 -m src.vanilla_pytorch.shortcut_pruning --model Resnets --batch-size 512 --epochs 30 --lr 0.01 --dataset cifar10 --use-swa --name ResNet_IMP_SWA1
deactivate
