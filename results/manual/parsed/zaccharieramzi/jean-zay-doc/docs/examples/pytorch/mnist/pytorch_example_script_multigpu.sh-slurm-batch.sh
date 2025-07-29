#!/bin/bash
#SBATCH --job-name=pytorch_mnist
#SBATCH --output=pytorch_mnist%j.out
#SBATCH --error=pytorch_mnist%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10

cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.4.0 
GAMMA_STEP=('0.1' '0.2' '0.3' '0.4' '0.5' '0.6' '0.7' '0.8' '0.9' '1.0') 
python ./mnist_example.py --gamma ${GAMMA_STEP[$SLURM_ARRAY_TASK_ID]} &
