#!/bin/bash
#SBATCH --account=${account_name}
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=256
#SBATCH --time=02:30:00
#SBATCH --partition=cpu
#SBATCH --qos=dev
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'

module load env/staging/2022.1
module load Python/3.10.4-GCCcore-11.3.0
ml SciPy-bundle/2022.05-foss-2022a 
ml PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
ml IPython/8.5.0-GCCcore-11.3.0
export OMP_NUM_THREADS=1
cd hpmlt
python __hpmlt__.py
