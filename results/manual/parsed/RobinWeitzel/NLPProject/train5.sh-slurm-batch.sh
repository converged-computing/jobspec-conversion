#!/bin/bash
#SBATCH --job-name=train5_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

module load python/3.6.3
module load gcc-7.1.0
python -m allennlp.run train training_config/bidaf_elmo_embedding.jsonnet -s output_elmo_embedding -f
