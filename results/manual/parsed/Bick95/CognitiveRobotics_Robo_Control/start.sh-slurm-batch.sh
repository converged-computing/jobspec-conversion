#!/bin/bash
#SBATCH --job-name=frnk6-5
#SBATCH --output=/dev/null
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10GB
#SBATCH --time=05:00:00

module load Python/3.6.4-foss-2019a
python main.py -p ParameterSettings/params_6.json
