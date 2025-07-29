#!/bin/bash
#SBATCH --job-name=nf_wf_manage
#SBATCH --output=slurm_logs/std_output_%j.out
#SBATCH --error=slurm_logs/std_error_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16gb
#SBATCH --time=23:59:59
#SBATCH --partition=nodes

nextflow pull J-81/dataset_prep_nf
nextflow run J-81/dataset_prep_nf \
  -r dev \
  -profile test \
  -with-tower \
  -resume
