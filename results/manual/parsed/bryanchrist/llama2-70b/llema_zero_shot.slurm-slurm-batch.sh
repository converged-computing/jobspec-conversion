#!/bin/bash
#SBATCH --job-name=llema_zero_shot
#SBATCH --account=sds_kropkoclass
#SBATCH --output=llema_zero_shot-%A.out
#SBATCH --error=llema_zero_shot-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=250G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=gpupod

export LD_LIBRARY_PATH='/opt/conda/lib/' '

module purge
module load anaconda
module load cuda/11.4.2
source activate falcon_40B
conda install -n falcon_40B python-dotenv
pip install -U -r requirements.txt
pip install -U --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/Triton-Nightly/pypi/simple/ triton-nightly
conda install -y cudatoolkit
export LD_LIBRARY_PATH='/opt/conda/lib/' 
python llema_zero_shot.py
