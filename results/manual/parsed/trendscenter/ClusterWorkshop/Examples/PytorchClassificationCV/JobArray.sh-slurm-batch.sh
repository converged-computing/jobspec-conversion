#!/bin/bash
#SBATCH --job-name=cworkshop_pytorch_cv
#SBATCH --account=trends53c17
#SBATCH --output=out%A_%a.out
#SBATCH --error=error%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=01:00:00

sleep 10s 
eval "$(conda shell.bash hook)"
conda activate cw_torch
cd $MYDIR/ClusterWorkshop/Examples/PytorchClassification
python -u mnist_classification.py --k $SLURM_ARRAY_TASK_ID
sleep 10s
