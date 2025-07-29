#!/bin/bash
#SBATCH --job-name=inference5
#SBATCH --account=project_2001284
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=150000
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu

id -a
module purge
module load pytorch/1.4
module list
python -W ignore -u inference.py -model_path ./checkpoint/S1-27_only_fertility_class/model_e150_nan.pt -save_dir ./inference/S1-27_only_fertility_class -gpu 0
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
