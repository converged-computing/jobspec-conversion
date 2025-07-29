#!/bin/bash
#SBATCH --account=y95
#SBATCH --mail-user=darcy.a.jones@postgrad.curtin.edu.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

module load nextflow/19.01.0.5050-bin
module load singularity/3.3.0
nextflow run -resume \
  -profile pawsey_zeus,singularity \
  ./main.nf \
  --seqs nr_leq5000.fasta \
  --msas clusters/msa \
  --enrich_seqs enrich_seqs.fasta \
  --noremote \
  --outdir run
