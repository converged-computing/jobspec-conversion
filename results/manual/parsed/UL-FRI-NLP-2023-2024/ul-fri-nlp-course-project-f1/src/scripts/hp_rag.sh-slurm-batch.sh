#!/bin/bash
#SBATCH --job-name=HP RAG
#SBATCH --output=logs/hp_rag.out
#SBATCH --error=logs/hp_rag.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --time=02:00:00

srun singularity exec --nv containers/container-rag.sif python src/hp_rag.py
