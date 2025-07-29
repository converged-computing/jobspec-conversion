#!/bin/bash
#SBATCH --job-name=GPU_matrix_add
#SBATCH --account=NTDD0002
#SBATCH --output=log.matrix_add_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=50G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module load cuda/11.0.3
module list
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo ${LD_LIBRARY_PATH}
nvidia-smi
echo -e "\nBeginning code output:\n-------------\n"
srun nvprof ./matrix_add.exe
