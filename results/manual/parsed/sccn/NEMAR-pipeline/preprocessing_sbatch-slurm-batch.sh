#!/bin/bash
#SBATCH --job-name=ds003645
#SBATCH --account=csd403
#SBATCH --output=/expanse/projects/nemar/openneuro/processed/logs/ds003645.out
#SBATCH --error=/expanse/projects/nemar/openneuro/processed/logs/ds003645.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=1-00:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=1
#SBATCH: --no-requeue

cd /home/dtyoung/NEMAR-pipeline
module load matlab
matlab -nodisplay -r "run_pipeline('ds003645');"
