#!/bin/bash
#SBATCH --output=A100_multi_output.o%j
#SBATCH --error=A100_multi_error.o%j
#SBATCH --mail-user=asarker@uni-osnabrueck.de
#SBATCH --mail-type=REQUEUE
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=54
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_SOCKET_IFNAME='lo'

echo "running in shell: " "$SHELL"
export NCCL_SOCKET_IFNAME=lo
spack load cuda@11.8.0
spack load cudnn@8.6.0.163-11.8
spack load miniconda3
eval "$(conda shell.bash hook)"
conda activate thesis
srun bash ./src/demo_train_rDL_SIM_Model.sh
