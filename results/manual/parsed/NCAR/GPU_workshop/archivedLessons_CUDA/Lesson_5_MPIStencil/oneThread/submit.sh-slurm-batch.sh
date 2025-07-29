#!/bin/bash
#SBATCH --job-name=GPU_stncl
#SBATCH --account=NTDD0002
#SBATCH --output=log.stncl_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'
export NV_ACC_TIME='1'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module load cuda/11.0.3
module list
echo -e "nvidia-smi output follows:"
nvidia-smi
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo -e "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
export NV_ACC_TIME=1
echo -e "\nBeginning code output:\n-------------\n"
srun ./acc_stencil.exe
echo -e "\nEnd of code output:\n-------------\n"
