#!/bin/bash
#SBATCH --job-name=gt_similarity_search
#SBATCH --output=log/pairings_pipeline-%j.log
#SBATCH --error=log/pairings_pipeline-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=aa100
#SBATCH --constraint=ntasks-per-node=32

snakemake -s training_pipeline.smk -j 32 -c 32 --use-conda --conda-frontend mamba
