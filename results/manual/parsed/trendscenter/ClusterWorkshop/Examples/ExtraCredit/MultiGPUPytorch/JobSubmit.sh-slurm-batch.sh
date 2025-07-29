#!/bin/bash
#SBATCH --job-name=cworkshop_pytorch
#SBATCH --account=trends53c17
#SBATCH --output=out%A.out
#SBATCH --error=error%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=20G
#SBATCH --time=01:00:00

sleep 10s 
eval "$(conda shell.bash hook)"
conda activate cw_torch
cd $MYDIR/ClusterWorkshop/Examples/ExtraCredit/MultiGPUPytorch
python -u dataparallel.py
sleep 10s
