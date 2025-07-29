#!/bin/bash
#SBATCH --account=y95
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00
#SBATCH --partition=work

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
nextflow run -resume -profile singularity,pawsey_setonix ./create_bloom.nf \
  --output_dir results \
  --input_fasta "$PWD/fasta/*fasta"
