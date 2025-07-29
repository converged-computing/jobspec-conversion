#!/bin/bash
#SBATCH --output=cuda-out.%j
#SBATCH --error=cuda-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=dp-dam

export PYTHON_EGG_CACHE='/p/project/joaiml/hpc_course/morris'

export PYTHON_EGG_CACHE=/p/project/joaiml/hpc_course/morris
ml CUDA
module load GCC/8.3.0 
module load ParaStationMPI/5.2.2-1
module load TensorFlow/1.13.1-GPU-Python-3.6.8
module load h5py/2.9.0-serial-Python-3.6.8 
module load scikit/2019a-Python-3.6.8
ml Intel ParaStationMPI
ml CUDA
module load extoll
module load pscom/5.3.1-1 
srun --cpu_bind=none python /p/home/jusers/riedel1/deep/2019-HPC-Course-MLDL-Parts/CNN-cpu.py
