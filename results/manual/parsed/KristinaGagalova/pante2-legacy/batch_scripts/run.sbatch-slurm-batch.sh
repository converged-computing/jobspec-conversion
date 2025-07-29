#!/bin/bash
#SBATCH --account=y95
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00

export NXF_SINGULARITY_CACHEDIR='./work'

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
export NXF_SINGULARITY_CACHEDIR="./work"
NXF_ANSI_LOG=false nextflow run KristinaGagalova/pante2-legacy -r main \
  -profile pawsey_setonix,singularity \
  -resume \
  --genomes "test/*.fasta" \
  --dfam_h5 "/path/to/dfam38_full.0.h5.gz" \
  --outdir "test/results"
