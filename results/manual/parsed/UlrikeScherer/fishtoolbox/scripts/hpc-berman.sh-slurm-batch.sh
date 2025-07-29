#!/bin/bash
#SBATCH --job-name=umap_clustering_berman
#SBATCH --output=res_%j.txt
#SBATCH --error=res_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30000
#SBATCH --time=00:34:00
#SBATCH --partition=ex_scioi_gpu

export LANG='UTF-8'
export LC_ALL='en_US.UTF-8'

module load nvidia/cuda/10.0    # load required modules (depends upon your code which modules are needed)
module load comp/gcc/7.2.0
source ~/miniconda3/etc/profile.d/conda.sh
echo "deactivating base env"
conda deactivate
echo "adding language encodings"
export LANG=UTF-8
export LC_ALL=en_US.UTF-8
echo "activating conda environment"
conda activate toolbox
echo "JOB START"
python hpc_berman.py
echo "JOB DONE"
echo "deactivating environments"
conda deactivate 
