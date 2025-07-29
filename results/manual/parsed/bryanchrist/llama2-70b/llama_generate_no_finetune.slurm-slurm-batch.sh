#!/bin/bash
#SBATCH --job-name=llama_generate_no_finetune
#SBATCH --account=sds-phd-2022
#SBATCH --output=generate_no_finetune-%A.out
#SBATCH --error=generate_no_finetune-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=200G
#SBATCH --time=01:00:00
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
python generate_not_finetuned.py
