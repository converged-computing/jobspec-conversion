#!/bin/bash
#SBATCH --job-name=Swa_Net2_Prune
#SBATCH --output=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/swa_net2.out
#SBATCH --error=/work/dlclarge1/dsengupt-lth_ws/nemo_logs/swa_net2.err
#SBATCH --mail-user=dipti.sengupta@students.uni-freiburg.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=19:59:00

cd $(ws_find lth_ws)
source lth_env/bin/activate
cd LTH_Master
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
python3 -m src.vanilla_pytorch.run_pruning_experiment --model Net2 --batch-size 60 --epochs 30 --lr 2e-4 --pruning-levels 20 --dataset cifar10 --name Net2SWARun1
deactivate
