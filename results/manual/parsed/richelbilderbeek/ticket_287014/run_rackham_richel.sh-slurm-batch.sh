#!/bin/bash
#FLUX: --job-name=ticket_287014
#FLUX: -n=4
#FLUX: --queue=core
#FLUX: -t=777600
#FLUX: --urgency=16

module load bioinfo-tools Nextflow 
rm -f metontiime2.nf
wget https://raw.githubusercontent.com/richelbilderbeek/MetONTIIME/master/metontiime2.nf
rm -f metontiime2.conf
wget https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf
sed -i 's/ 10.GB / 7.GB /' metontiime2.conf
sed -i "s/executor = 'pbspro'/executor = 'local'/" metontiime2.conf
sed -i "s/clusteringIdentity=1/clusteringIdentity=0.97/" metontiime2.conf
sed -i "s/filterFastq = true/filterFastq = false/" metontiime2.conf
sed -i "s/downsampleFastq = true/downsampleFastq = false/" metontiime2.conf
echo "Script generated and used:"
cat metontiime2.conf
echo " "
work_dir="/crex/proj/staff/richel/ticket_287014_output/work_local_singularity"
echo "work_dir: ${work_dir}"
mkdir "${work_dir}"
cp /crex/proj/naiss2023-22-866/MetONTIIME/trimmed_and_filtered_Q15_qz/seqkitQ15cutadaptlib1sup_bc01.fastq.gz "${work_dir}"
results_dir="/crex/proj/staff/richel/ticket_287014_output/results_local_singularity"
echo "results_dir: ${results_dir}"
db_sequence_fasta_filename="/crex/proj/naiss2023-22-866/MetONTIIME/sh_refs_qiime_ver9_dynamic_all_25.07.2023.fasta"
echo "db_sequence_fasta_filename: ${db_sequence_fasta_filename}"
sample_metadata_tsv_filename="${PWD}/example_sample_metadata.tsv"
echo "sample_metadata_tsv_filename: ${sample_metadata_tsv_filename}"
taxonomy_tsv_filename="/crex/proj/naiss2023-22-866/MetONTIIME/noheader_taxonomy_qiime_ver9_dynamic_alleukaryotes_25.07.2023.tsv"
echo "taxonomy_tsv_filename: ${taxonomy_tsv_filename}"
config_filename="${PWD}/metontiime2.conf"
nextflow -c "${config_filename}" run metontiime2.nf \
  --workDir="${work_dir}" \
  --resultsDir="${results_dir}" \
  --dbSequencesFasta="${db_sequence_fasta_filename}" \
  --sampleMetadata="${sample_metadata_tsv_filename}" \
  --dbTaxonomyTsv="${taxonomy_tsv_filename}" \
  -profile singularity
