#!/bin/bash
#SBATCH --job-name=HISAT_qtlmap
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-12:00:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=1

module load java-1.8.0_40
module load nextflow
module load singularity/3.5.3
module load squashfs/4.4
nextflow run main.nf -profile tartu_hpc,eqtl_catalogue -resume\
  --studyFile /gpfs/space/home/kerimov/qcnorm_fast/results_leafcutter_HISAT_GEUVADIS/GEUVADIS/GEUVADIS_qtlmap_inputs.tsv\
  --outdir /gpfs/space/home/kerimov/qtlmap_lc_hisat/GEUVADIS_HISAT_qtlmap_results/\
  --vcf_has_R2_field FALSE\
  --vcf_genotype_field DS\
  --covariates sex\
  --susie_skip_full TRUE
