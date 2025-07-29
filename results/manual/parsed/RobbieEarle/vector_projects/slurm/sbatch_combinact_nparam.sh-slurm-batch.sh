#!/bin/bash
#SBATCH --job-name=wrn50_cf100
#SBATCH --output=logs_new/wrn50_cf100/%a-%N-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=29-04:00:00
#SBATCH --qos=normal
#SBATCH --array=0-10%11

source ~/.bashrc
source activate ~/venvs/combinact
SEED="$1"
ACTFUN_IDX="$SLURM_ARRAY_TASK_ID"
SAVE_PATH=~/vector_projects/outputs/wrn50_cf100
CHECK_PATH="/checkpoint/$USER/${SLURM_JOB_ID}"
touch $CHECK_PATH
pwd
which conda
python --version
pip freeze
echo ""
python -c "import torch; print('torch version = {}'.format(torch.__version__))"
python -c "import torch.cuda; print('cuda = {}'.format(torch.cuda.is_available()))"
python -c "import scipy; print('scipy version = {}'.format(scipy.__version__))"
python -c "import sklearn; print('sklearn version = {}'.format(sklearn.__version__))"
python -c "import matplotlib; print('matplotlib version = {}'.format(matplotlib.__version__))"
echo ""
echo "SAVE_PATH=$SAVE_PATH"
echo "SEED=$SEED"
python engine.py --seed $SEED --save_path $SAVE_PATH --check_path $CHECK_PATH --model resnet --batch_size 128 --actfun_idx $ACTFUN_IDX --optim onecycle --num_epochs 100 --dataset cifar100 --aug --mix_pre_apex --bs_factor 0.75
