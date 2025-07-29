#!/bin/bash
#SBATCH --job-name=GPU_matmul
#SBATCH --account=NTDD0002
#SBATCH --output=log.matmul_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'
export PCAST_COMPARE='abs=6,summary'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module list
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo ${LD_LIBRARY_PATH}
nvidia-smi
export PCAST_COMPARE=abs=6,summary
echo -e "\nBeginning code output:\n-------------\n"
srun ./matmul.exe 
