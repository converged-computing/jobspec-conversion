#!/bin/bash
#SBATCH --account=researchers
#SBATCH --output=logs/pruning_imbalanced/R-%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=120G
#SBATCH --time=02:00:00

echo "prune_percent=$1"
echo "metric=$2"
echo "model_name=$3"
echo "path=$4"
echo "prunetask=$5"
echo "group_metrics=$6"
echo "prune_method=$7"
python main.py $1 $2 $3 $4 $5 $6 $7
