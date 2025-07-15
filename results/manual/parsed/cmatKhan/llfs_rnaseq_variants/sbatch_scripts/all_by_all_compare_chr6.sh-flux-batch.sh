#!/bin/bash
#FLUX: --job-name=stanky-rabbit-5496
#FLUX: -t=3600
#FLUX: --urgency=16

eval $(spack load --sh singularityce@3.11.4)
singularity_image=/scratch/mblab/chasem/llfs_rna_dna_compare_test/llfs_rnaseq_latest.sif
wgs_dna_subjects=/scratch/mblab/chasem/llfs_rna_dna_compare_test/lookups/wgs_dna_subject_ids.txt
dna_gds=/ref/mblab/data/llfs/agds/LLFS.WGS.freeze5.chr6.gds
chr=6
rna_sample=$1
visit=$2
rna_gds=$3
output_dir=$4
read dna_sample < <(sed -n ${SLURM_ARRAY_TASK_ID}p "$wgs_dna_subjects")
singularity exec \
  -B /scratch/mblab \
  -B /ref/mblab \
  -B "$PWD" \
  $singularity_image \
  /bin/bash -c \
  "cd $PWD; \
   export R_LIBS=/project/renv/library/R-4.2/x86_64-pc-linux-gnu; \
   /scratch/mblab/chasem/llfs_rna_dna_compare_test/llfs_rnaseq_variants/scripts/extract_rna_dna_overlap_genotypes.R \
   --chr $chr \
   --rna_sample $rna_sample \
   --rna_visit $visit \
   --dna_sample $dna_sample \
   --dna $dna_gds \
   --rna $rna_gds \
   --output_prefix $output_dir"
