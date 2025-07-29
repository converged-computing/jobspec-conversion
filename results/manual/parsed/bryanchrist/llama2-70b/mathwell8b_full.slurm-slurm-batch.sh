#!/bin/bash
#SBATCH --job-name=mathwell8b_full_generate
#SBATCH --account=sds_dl_phd
#SBATCH --output=mathwell8b_full_generate-%A.out
#SBATCH --error=mathwell8b_full_generate-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00
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
python mathwell8b_full.py
