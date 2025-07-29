#!/bin/bash
#SBATCH --job-name=tf_mnist_multi_gpus
#SBATCH --output=tf_mnist_multi_gpus%A_%a.out
#SBATCH --error=tf_mnist_multi_gpus%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-1

set -x
cd ${SLURM_SUBMIT_DIR}
opt[0]=""
opt[1]=""
module purge
module load tensorflow-gpu/py3/2.1.0
srun python ./mnist_example.py ${opt[$SLURM_ARRAY_TASK_ID]}
wait
