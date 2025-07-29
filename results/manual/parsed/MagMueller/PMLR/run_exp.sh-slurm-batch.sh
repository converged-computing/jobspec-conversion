#!/bin/bash
#SBATCH --job-name=corrn_gpu_job
#SBATCH --output=log/corrn_job%j.out
#SBATCH --error=log/corrn_job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=16G
#SBATCH --time=10:00:00

module load  cuda/11.8.0 
module load  eth_proxy
module load gcc/9.3.0 python/3.11.2
cd $HOME/PMLR
source pmlr_env/bin/activate
python main.py
