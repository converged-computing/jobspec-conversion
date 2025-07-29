#!/bin/bash
#SBATCH --job-name=phi3_solve
#SBATCH --account=bryan_research
#SBATCH --output=phi3_solve-%A.out
#SBATCH --error=phi3_solve-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=50G
#SBATCH --time=2-00:00:00
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
python phi3.py
