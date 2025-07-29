#!/bin/bash
#SBATCH --job-name=sbatch
#SBATCH --output=out_sbatch.txt
#SBATCH --error=err_sbatch.txt
#SBATCH --mail-user=ky8517@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --qos=10

module load anaconda3/5.0.1
source activate tf1-gpu
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.5.0
whereis nvcc
which nvcc
nvcc --version
cd /scratch/gpfs/ky8517/leaf-torch/data/femnist
pwd
python3 -V
./preprocess.sh
