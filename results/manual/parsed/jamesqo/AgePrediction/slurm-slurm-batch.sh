#!/bin/bash
#SBATCH --account=fnndsc
#SBATCH --output=logs/slurm-%j.out
#SBATCH --mail-user=jamesqko@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:Titan_RTX:1
#SBATCH --mem=30G
#SBATCH --time=5-00:00:00

module load anaconda3
source activate james
pip install --user -r requirements.txt
python -m age_prediction.train --job-id $SLURM_JOB_ID "$@"
