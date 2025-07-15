#!/bin/bash
#FLUX: --job-name=blank-taco-9462
#FLUX: --urgency=16

module load bioinfo-tools Nextflow 
work_dir="/crex/proj/naiss2023-22-866/MetONTIIME/trimmed_and_filtered_Q15_qz"
echo "work_dir: ${work_dir}"
results_dir="/crex/proj/naiss2023-22-866/MetONTIIME/Output"
echo "results_dir: ${results_dir}"
db_sequence_fasta_filename="/crex/proj/naiss2023-22-866/Illumina_Qiime2_and_BLAST/sh_refs_qiime_ver9_dynamic_all_25.07.2023.fasta"
echo "db_sequence_fasta_filename: ${db_sequence_fasta_filename}"
sample_metadata_tsv_filename="${PWD}/example_sample_metadata.tsv"
echo "sample_metadata_tsv_filename: ${sample_metadata_tsv_filename}"
taxonomy_tsv_filename="/crex/proj/naiss2023-22-866/MetONTIIME/noheader_taxonomy_qiime_ver9_dynamic_alleukaryotes_25.07.2023.tsv"
echo "taxonomy_tsv_filename: ${taxonomy_tsv_filename}"
config_filename="${PWD}/metontiime2.conf"
nextflow -c "${config_filename}" \
  run -resume metontiime2.nf \
  --workDir="${work_dir}" \
  --resultsDir="${results_dir}" \
  --dbSequencesFasta="${db_sequence_fasta_filename}" \
  --sampleMetadata="${sample_metadata_tsv_filename}" \
  --dbTaxonomyTsv="${taxonomy_tsv_filename}" \
  -profile singularity
