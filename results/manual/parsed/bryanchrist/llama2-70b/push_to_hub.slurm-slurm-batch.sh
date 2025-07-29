#!/bin/bash
#SBATCH --job-name=push_to_hub
#SBATCH --account=bryan_research
#SBATCH --output=push_to_hub-%A.out
#SBATCH --error=push_to_hub-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=250G
#SBATCH --time=12:00:00
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
python push_to_hub.py
