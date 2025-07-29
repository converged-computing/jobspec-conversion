#!/bin/bash
#SBATCH --job-name=iVAE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH --chdir=/proj/barimpac/beyond-NonSENS/iVAE/

export LC_ALL='en_US.utf-8'
export LANG='en_US.utf-8'

module purge
module load Python/3.6.6-foss-2018b
module load cuDNN/7.5.0.56-CUDA-10.0.130
source /wrk/users/barimpac/research/bin/activate
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
srun python3 main.py --config binary-5-identity-adam-Copy9.yaml --n-sims 3 --m 2.0 --s 3 --ckpt_folder='run/checkpoints/'
