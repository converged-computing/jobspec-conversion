#!/bin/bash
#SBATCH --account=y95
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00
#SBATCH --partition=work

module load nextflow/22.10.0
module load singularity/3.11.4-slurm
NXF_ANSI_LOG=false nextflow run KristinaGagalova/pante2-legacy -r main \
  -profile pawsey_setonix \
  -resume \
  --rnammer \
  --genomes "test/*.fasta" \
  --outdir "test/results" \
  --dfam_h5 "/path/to/dfam_db/dfam38_full.0.h5.gz" \
  -with-singularity containers/singularity/pante2-rnammer-legacy.sif
