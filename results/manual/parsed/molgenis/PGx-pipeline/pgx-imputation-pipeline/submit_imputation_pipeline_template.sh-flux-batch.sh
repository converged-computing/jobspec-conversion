#!/bin/bash
#FLUX: --job-name=ImputeGenotypes
#FLUX: -t=259200
#FLUX: --urgency=16

module load java-1.8.0_40
module load singularity/3.5.3
module load squashfs/4.4
nextflow_path=[full path to your Nextflow executable]
reference_path=[full path to your folder with reference files]
input_path=[full path to your input genotype folder]
output_name=[name of the output files]
output_path=[name of the output path]
${nextflow_path}/nextflow run main.nf \
--bfile ${input_path} \
--target_ref ${reference_path}/hg38/ref_genome_QC/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--ref_panel_hg38 ${reference_path}/hg38/ref_panel_QC/30x-GRCh38_NoSamplesSorted \
--eagle_genetic_map ${reference_path}/hg38/phasing/genetic_map/genetic_map_hg38_withX.txt.gz \
--eagle_phasing_reference ${reference_path}/hg38/phasing/phasing_reference/ \
--minimac_imputation_reference ${reference_path}/hg38/imputation/ \
--output_name ${output_name} \
--outdir ${output_path}  \
--profile slurm \
-resume
