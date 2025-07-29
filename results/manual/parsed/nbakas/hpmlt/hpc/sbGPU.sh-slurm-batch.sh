#!/bin/bash
#SBATCH --account=${account_name}
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=dev
#SBATCH --constraint=ntasks-per-node=4

module load env/staging/2022.1
module load Python/3.10.4-GCCcore-11.3.0
ml SciPy-bundle/2022.05-foss-2022a 
ml PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
ml IPython/8.5.0-GCCcore-11.3.0
cd hpmlt
python __hpmlt__.py
