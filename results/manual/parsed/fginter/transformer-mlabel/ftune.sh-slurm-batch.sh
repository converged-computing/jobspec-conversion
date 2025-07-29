#!/bin/bash
#SBATCH --job-name=cf42
#SBATCH --account=project_2002029
#SBATCH --output=train2.out
#SBATCH --error=train2.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=14G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export PYTHONPATH='../venv-torch/lib64/python3.7/site-packages:$PYTHONPATH'

LR=$1
module purge
module load pytorch/1.3.0
PROJDIR=$HOME/proj_deepsequence/scratch/ginter/cafa
source $PROJDIR/venv-torch/bin/activate
export PYTHONPATH=../venv-torch/lib64/python3.7/site-packages:$PYTHONPATH
python3 train.py --train CAFA4-ctrl/train.torchbin --dev CAFA4-ctrl/devel.torchbin --max-labels 5000 --class-stats-file CAFA4-ctrl/class-stats.json --store-cpoint fix-norank-checkpoint-CAFA4-ctrl.$LR --lrate $LR --report-every 1000
