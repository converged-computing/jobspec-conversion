#!/bin/bash
#SBATCH --account=acc_ure_power_std
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --partition=power_std
#SBATCH --array=1-4

source ~/anaconda3/etc/profile.d/conda.sh
conda activate pytorch
cd ../src/runs
argumentos[${#argumentos[@]}]="dense --dataset CIFAR10 --pool_type grouping_product --config_file_name", "densenet_parameters.json --name dense_pool_grouping_product"
argumentos[${#argumentos[@]}]="dense --dataset CIFAR10 --pool_type grouping_maximum --config_file_name", "densenet_parameters.json --name dense_pool_grouping_maximum"
argumentos[${#argumentos[@]}]="dense --dataset CIFAR10 --pool_type grouping_ob --config_file_name", "densenet_parameters.json --name dense_pool_grouping_ob"
argumentos[${#argumentos[@]}]="dense --dataset CIFAR10 --pool_type grouping_geometric --config_file_name", "densenet_parameters.json --name dense_pool_grouping_geometric"
srun python run_test.py ${argumentos[SLURM_ARRAY_TASK_ID-1]}
