#!/bin/bash
#SBATCH --job-name=debug
#SBATCH --account=vita
#SBATCH --output=out/slurm-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=1

echo started at `date`
module load gcc/8.4.0-cuda cuda/10.2.89
source /home/wexiong/anaconda3/bin/activate base 
conda activate pytorch 
echo "${@:1}"
python -u "${@:1}"
wait 
echo finished at `date`
