#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=05:00:00

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module load Anaconda3/5.3.0
source activate venv
find "${1}/dags" -maxdepth 1 -mindepth 1 -type d | xargs -I {} bash run.sh "{}" $2
python process_seed_results.py -s $1 -r "t${2}/results.json" -t $2
find "${1}/dags" -maxdepth 1 -mindepth 1 -type d | xargs -I {} rm -r "{}/t${2}"
