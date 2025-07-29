#!/bin/bash
#SBATCH --job-name=generative_capability1e-3
#SBATCH --mail-user=nikita.tokovenko@student.uva.nl
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=60000M
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load eb
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
source activate thesis_env
srun python3 -u generative_capability.py --layers_to_track 1,2,3 --weight_decay 1e-3
