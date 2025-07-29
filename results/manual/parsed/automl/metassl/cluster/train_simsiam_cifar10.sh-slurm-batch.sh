#!/bin/bash
#SBATCH --job-name=SimSiam_Cifar10
#SBATCH --output=/work/dlclarge1/dsengupt-lth_ws/slurm_logs/simsiam_train.out
#SBATCH --error=/work/dlclarge1/dsengupt-lth_ws/slurm_logs/simsiam_train.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=19:59:00

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
cd MetaSSL/metassl/
echo "Pretrain Simsiam with CIFAR10 and Knn Run 2"
python3 -m metassl.train_simsiam --expt_name run2_simsiam_cifar10 --epochs 500 --expt_mode CIFAR10 --workers 8 --seed 125 --run_knn_val
deactivate
