#!/bin/bash
#FLUX: --job-name=eccentric-gato-6190
#FLUX: -t=1800
#FLUX: --urgency=16

eval $(spack load --sh singularityce@3.11.4)
singularity_image=/scratch/mblab/chasem/llfs_rna_dna_compare_test/llfs_rnaseq_latest.sif
read rna_subject_id visit dna_subject_id rna_gds chr dna_gds output_dir < <(sed -n ${SLURM_ARRAY_TASK_ID}p "$1")
singularity exec \
  -B /scratch/mblab \
  -B "$PWD" \
  -B /ref/mblab/data \
  $singularity_image \
  /bin/bash -c \
  "cd $PWD; \
   /scratch/mblab/chasem/llfs_rna_dna_compare_test/llfs_rnaseq_variants/scripts/extract_rna_dna_overlap_genotypes.R \
   --chr $chr \
   --rna_sample $rna_subject_id \
   --rna_visit $visit \
   --dna_sample $dna_subject_id \
   --dna $dna_gds \
   --rna $rna_gds \
   --output_prefix $output_dir"
