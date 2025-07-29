#!/bin/bash
#SBATCH --job-name=llama_generate
#SBATCH --account=ds4002fa22
#SBATCH --output=generate-%A.out
#SBATCH --error=generate-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=200G
#SBATCH --time=12:00:00
#SBATCH --constraint=gpupod

export LD_LIBRARY_PATH='/opt/conda/lib/' '

module purge
module load anaconda
module load cuda/11.4.2
source activate falcon_40B
conda install -n falcon_40B python-dotenv
pip install -U -r requirements.txt
conda install -y cudatoolkit
export LD_LIBRARY_PATH='/opt/conda/lib/' 
python generate.py
