#!/bin/bash
#SBATCH --account=def-bentahar
#SBATCH --output=/home/fgrcl/scratch/job-logs/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=125G
#SBATCH --time=5-00:00:00
#SBATCH --array=1-$2

sbatch <<EOT
module load python/3.10 cuda cudnn
source venv/bin/activate
pip install --no-index --upgrade pip
pip install -r requirements.txt
export $(cat .env | xargs)
wandb agent --count 1 $1
EOT
