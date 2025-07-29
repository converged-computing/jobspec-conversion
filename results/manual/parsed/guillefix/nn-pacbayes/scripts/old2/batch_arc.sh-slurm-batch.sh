#!/bin/bash
#SBATCH --job-name=single_core
#SBATCH --mail-user=guillefix@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:4
#SBATCH --time=1-00:00:00
#SBATCH --partition=htc
#SBATCH --constraint=ntasks-per-node=4

module load anaconda3/2019.03
module load gpu/cuda/10.0.130
module load gpu/cudnn/7.5.0__cuda-10.0
module load mpi
source activate $DATA/tensor-env
./meta_script_msweep_arc mnist fc none 1
