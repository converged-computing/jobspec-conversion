#!/bin/bash
#FLUX: --job-name=20220323-pgen-nextflow_rnaseq-tissues
#FLUX: --queue=srlab
#FLUX: -t=1468800
#FLUX: --urgency=16

nf_core_rnaseq="/gscratch/srlab/programs/nf-core-rnaseq-3.6/workflow"
nf_core_rnaseq_config=/gscratch/srlab/programs/nf-core-rnaseq-3.6/configs/conf/base-srlab_500GB_node.config
wd=$(pwd)
reads_dir=/gscratch/srlab/sam/data/P_generosa/RNAseq
genome_fasta=/gscratch/srlab/sam/data/P_generosa/genomes/Panopea-generosa-v1.0.fa
genome_gff=/gscratch/srlab/sam/data/P_generosa/genomes/Panopea-generosa-v1.0.a4_biotype-trna_strand_converted-no_RNAmmer.gff
R1_array=()
R2_array=()
R1_uncompressed_array=()
R2_uncompressed_array=()
set -e
. "/gscratch/srlab/programs/anaconda3/etc/profile.d/conda.sh"
conda activate nf-core_env
module load singularity
sample_sheet_header="sample,fastq_1,fastq_2,strandedness"
printf "%s\n" "${sample_sheet_header}" >> sample_sheet-"${SLURM_JOB_ID}".csv
R1_uncompressed_array=("${reads_dir}"/*_1.fastq)
R2_uncompressed_array=("${reads_dir}"/*_2.fastq)
if [[ "${#R1_uncompressed_array[@]}" != "${#R2_uncompressed_array[@]}" ]]
then
  echo ""
  echo "Uncompressed array sizes don't match."
  echo "Confirm all expected FastQs are present in ${reads_dir}"
  echo ""
  exit
fi
for fastq in "${!R1_uncompressed_array[@]}"
do
  # Strip leading path
	no_path=$(echo "${R1_uncompressed_array[${fastq}]##*/}")
  # Grab SRA name
  sra=$(echo "${no_path}" | awk -F "_" '{print $1}')
  # Only gzip matching FastQs
  # Only generate MD5 checksums for matching FastQs
  if [[ "${sra}" == "SRR12218868" ]] \
    || [[ "${sra}" == "SRR12218869" ]] \
    || [[ "${sra}" == "SRR12226692" ]] \
    || [[ "${sra}" == "SRR12218870" ]] \
    || [[ "${sra}" == "SRR12226693" ]] \
    || [[ "${sra}" == "SRR12207404" ]] \
    || [[ "${sra}" == "SRR12207405" ]] \
    || [[ "${sra}" == "SRR12227930" ]] \
    || [[ "${sra}" == "SRR12207406" ]] \
    || [[ "${sra}" == "SRR12207407" ]] \
    || [[ "${sra}" == "SRR12227931" ]] \
    || [[ "${sra}" == "SRR12212519" ]] \
    || [[ "${sra}" == "SRR12227929" ]] \
    || [[ "${sra}" == "SRR8788211" ]]
  then
    echo ""
    echo "Generating MD5 checksums for ${R1_uncompressed_array[${fastq}]} and ${R2_uncompressed_array[${fastq}]}."
    echo ""
    # Generate MD5 checksums of uncompressed FastQs
    {
      md5sum "${R1_uncompressed_array[${fastq}]}"
      md5sum "${R2_uncompressed_array[${fastq}]}"
    } >> uncompressed_fastqs-"${SLURM_JOB_ID}".md5
    # Gzip FastQs; NF Core RNAseq requires gzipped FastQs as inputs
    echo "Compressing FastQ files."
    if [ ! -f "${R1_uncompressed_array[${fastq}]}.gz" ]
    then 
      gzip --keep "${R1_uncompressed_array[${fastq}]}"
      gzip --keep "${R2_uncompressed_array[${fastq}]}"
    else 
      echo "${R1_uncompressed_array[${fastq}]}.gz already exists. Skipping."
    fi
    echo ""
  fi
done
R1_array=("${reads_dir}"/*_1.fastq.gz)
R2_array=("${reads_dir}"/*_2.fastq.gz)
if [[ "${#R1_array[@]}" != "${#R2_array[@]}" ]]
  then
    echo ""
    echo "Read1 and Read2 compressed FastQ array sizes don't match."
    echo "Confirm all expected compressed FastQs are present in ${reads_dir}"
    echo ""
    exit
fi
for fastq in "${!R1_array[@]}"
do
  echo ""
  echo "Generating MD5 checksums for ${R1_array[${fastq}]} and ${R2_array[${fastq}]}."
  echo ""
  # Generate MD5 checksums for compressed FastQs used in NF Core RNAseq analysis
  {
    md5sum "${R1_array[${fastq}]}"
    md5sum "${R2_array[${fastq}]}"
  } >> input_fastqs-"${SLURM_JOB_ID}".md5
  # Strip leading path
	no_path=$(echo "${R1_array[${fastq}]##*/}")
  # Grab SRA name
  sra=$(echo "${no_path}" | awk -F "_" '{print $1}')
  # Set tissue type
  if [[ "${sra}" == "SRR12218868" ]]
  then
    tissue="heart"
    # Add to NF Core RNAseq sample sheet
    printf "%s,%s,%s,%s\n" "${tissue}" "${R1_array[${fastq}]}" "${R2_array[${fastq}]}" "reverse" \
    >> sample_sheet-"${SLURM_JOB_ID}".csv
  elif [[ "${sra}" == "SRR12218869" ]] \
    || [[ "${sra}" == "SRR12226692" ]]
  then
    tissue="gonad"
    # Add to NF Core RNAseq sample sheet
    printf "%s,%s,%s,%s\n" "${tissue}" "${R1_array[${fastq}]}" "${R2_array[${fastq}]}" "reverse" \
    >> sample_sheet-"${SLURM_JOB_ID}".csv
  elif [[ "${sra}" == "SRR12218870" ]] \
    || [[ "${sra}" == "SRR12226693" ]]
  then
    tissue="ctenidia"
    # Add to NF Core RNAseq sample sheet
    printf "%s,%s,%s,%s\n" "${tissue}" "${R1_array[${fastq}]}" "${R2_array[${fastq}]}" "reverse" \
    >> sample_sheet-"${SLURM_JOB_ID}".csv
  elif [[ "${sra}" == "SRR12207404" ]] \
    || [[ "${sra}" == "SRR12207405" ]] \
    || [[ "${sra}" == "SRR12227930" ]] \
    || [[ "${sra}" == "SRR12207406" ]] \
    || [[ "${sra}" == "SRR12207407" ]] \
    || [[ "${sra}" == "SRR12227931" ]]
  then
    tissue="juvenile"
    # Add to NF Core RNAseq sample sheet
    printf "%s,%s,%s,%s\n" "${tissue}" "${R1_array[${fastq}]}" "${R2_array[${fastq}]}" "reverse" \
    >> sample_sheet-"${SLURM_JOB_ID}".csv
  elif [[ "${sra}" == "SRR12212519" ]] \
    || [[ "${sra}" == "SRR12227929" ]] \
    || [[ "${sra}" == "SRR8788211" ]]
  then
    tissue="larvae"
    # Add to NF Core RNAseq sample sheet
    printf "%s,%s,%s,%s\n" "${tissue}" "${R1_array[${fastq}]}" "${R2_array[${fastq}]}" "reverse" \
    >> sample_sheet-"${SLURM_JOB_ID}".csv
  fi
done
echo "Beginning NF-Core RNAseq pipeline..."
echo ""
nextflow run ${nf_core_rnaseq} \
-profile singularity \
-c ${nf_core_rnaseq_config} \
--input sample_sheet-"${SLURM_JOB_ID}".csv \
--outdir ${wd} \
--multiqc_title "20220321-pgen-nextflow_rnaseq-tissues-${SLURM_JOB_ID}" \
--fasta ${genome_fasta} \
--gff ${genome_gff} \
--save_reference \
--gtf_extra_attributes gene_name \
--gtf_group_features gene_id \
--featurecounts_group_type gene_biotype \
--featurecounts_feature_type exon \
--trim_nextseq 20 \
--save_trimmed \
--aligner star_salmon \
--pseudo_aligner salmon \
--min_mapped_reads 5 \
--save_align_intermeds \
--rseqc_modules bam_stat,\
inner_distance,\
infer_experiment,\
junction_annotation,\
junction_saturation,\
read_distribution,\
read_duplication
cp "${nf_core_rnaseq_config}" .
{
  date
  echo ""
  echo "System PATH for $SLURM_JOB_ID"
  echo ""
  printf "%0.s-" {1..10}
  echo "${PATH}" | tr : \\n
} >> system_path.log
echo "Finished logging system PATH"
