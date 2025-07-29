#!/bin/bash
#SBATCH --account=def-skelly
#SBATCH --error=error_file.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=3-00:10:00
#SBATCH --constraint=ntasks-per-node=64

seed=$1
module load python/3.10
python models/generator_TPG.PY -s $seed  --num_proc 64
