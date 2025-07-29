#!/bin/bash
#SBATCH --job-name=time_blast
#SBATCH --output=R-%x.%J.out
#SBATCH --error=R-%x.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

module load nextflow
module load blast       # or ncbi
nextflow run main.nf \
  --db "/path/to/nt.fasta" \
  --query "*.fasta" \
  --options '-outfmt 6 -num_alignments 1'
  --threads 50
