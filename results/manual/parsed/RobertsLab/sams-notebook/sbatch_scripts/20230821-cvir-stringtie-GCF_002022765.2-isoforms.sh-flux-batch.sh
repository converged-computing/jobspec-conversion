#!/bin/bash
#FLUX: --job-name=20230821-cvir-stringtie-GCF_002022765.2-isoforms
#FLUX: --queue=srlab
#FLUX: -t=302400
#FLUX: --urgency=16

threads=28
genome_index_name="cvir_GCF_002022765.2"
HISAT2_INDEXES=$(pwd)
export HISAT2_INDEXES
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2="${hisat2_dir}/hisat2"
samtools="/gscratch/srlab/programs/samtools-1.10/samtools"
stringtie="/gscratch/srlab/programs/stringtie-2.2.1.Linux_x86_64/stringtie"
prepDE="/gscratch/srlab/programs/stringtie-2.2.1.Linux_x86_64/prepDE.py3"
genome_index_dir="/gscratch/srlab/sam/data/C_virginica/genomes"
genome_gff="${genome_index_dir}/GCF_002022765.2_C_virginica-3.0_genomic.gff"
fastq_dir="/gscratch/srlab/sam/data/C_virginica/RNAseq/"
gtf_list="gtf_list.txt"
merged_bam="20230821_cvir_stringtie_GCF_002022765-sorted-bams-merged.bam"
declare -A samples_associative_array=()
total_samples=26
declare -A programs_array
programs_array=(
[hisat2]="${hisat2}" \
[prepDE]="${prepDE}" \
[samtools_index]="${samtools} index" \
[samtools_merge]="${samtools} merge" \
[samtools_sort]="${samtools} sort" \
[samtools_view]="${samtools} view" \
[stringtie]="${stringtie}"
)
set -e
module load intel-python3_2017
sample_counter=0
for fastq in "${fastq_dir}"*_R1.fastp-trim.20bp-5prime.20220224.fq.gz
do
  # Increment counter
  ((sample_counter+=1))
  # Remove path
  sample_name="${fastq##*/}"
  # Get sample name from first _-delimited field
  sample_name=$(echo "${sample_name}" | awk -F "_" '{print $1}')
  # Set treatment condition for each sample
  if [[ "${sample_name}" == "S12M" ]] \
  || [[ "${sample_name}" == "S22F" ]] \
  || [[ "${sample_name}" == "S23M" ]] \
  || [[ "${sample_name}" == "S29F" ]] \
  || [[ "${sample_name}" == "S31M" ]] \
  || [[ "${sample_name}" == "S35F" ]] \
  || [[ "${sample_name}" == "S36F" ]] \
  || [[ "${sample_name}" == "S3F" ]] \
  || [[ "${sample_name}" == "S41F" ]] \
  || [[ "${sample_name}" == "S48F" ]] \
  || [[ "${sample_name}" == "S50F" ]] \
  || [[ "${sample_name}" == "S59M" ]] \
  || [[ "${sample_name}" == "S77F" ]] \
  || [[ "${sample_name}" == "S9M" ]]
  then
    treatment="exposed"
  else
    treatment="control"
  fi
  # Append to associative array
  samples_associative_array+=(["${sample_name}"]="${treatment}")
done
if [[ "${#samples_associative_array[@]}" != "${sample_counter}" ]] \
|| [[ "${#samples_associative_array[@]}" != "${total_samples}" ]]
  then
    echo "samples_associative_array doesn't have all 26 samples."
    echo ""
    echo "samples_associative_array contents:"
    echo ""
    for item in "${!samples_associative_array[@]}"
    do
      printf "%s\t%s\n" "${item}" "${samples_associative_array[${item}]}"
    done
    exit
fi
rsync -av "${genome_index_dir}"/${genome_index_name}*.ht2 .
for sample in "${!samples_associative_array[@]}"
do
  ## Inititalize arrays
  fastq_array_R1=()
  fastq_array_R2=()
  # Create array of fastq R1 files
  # and generated MD5 checksums file.
  for fastq in "${fastq_dir}""${sample}"*_R1.fastp-trim.20bp-5prime.20220224.fq.gz
  do
    fastq_array_R1+=("${fastq}")
    echo "Generating checksum for ${fastq}..."
    md5sum "${fastq}" >> input_fastqs_checksums.md5
    echo "Checksum for ${fastq} completed."
    echo ""
  done
  # Create array of fastq R2 files
  for fastq in "${fastq_dir}""${sample}"*_R2.fastp-trim.20bp-5prime.20220224.fq.gz
  do
    fastq_array_R2+=("${fastq}")
    echo "Generating checksum for ${fastq}..."
    md5sum "${fastq}" >> input_fastqs_checksums.md5
    echo "Checksum for ${fastq} completed."
    echo ""
  done
  # Create comma-separated lists of FastQs for Hisat2
  printf -v joined_R1 '%s,' "${fastq_array_R1[@]}"
  fastq_list_R1=$(echo "${joined_R1%,}")
  printf -v joined_R2 '%s,' "${fastq_array_R2[@]}"
  fastq_list_R2=$(echo "${joined_R2%,}")
  # Create and switch to dedicated sample directory
  mkdir "${sample}" && cd "$_"
  # Hisat2 alignments
  # Sets read group info (RG) using samples array
  "${programs_array[hisat2]}" \
  -x "${genome_index_name}" \
  -1 "${fastq_list_R1}" \
  -2 "${fastq_list_R2}" \
  -S "${sample}".sam \
  --rg-id "${sample}" \
  --rg "SM:""${samples_associative_array[$sample]}" \
  2> "${sample}"_hisat2.err
  # Sort SAM files, convert to BAM, and index
  ${programs_array[samtools_view]} \
  -@ "${threads}" \
  -Su "${sample}".sam \
  | ${programs_array[samtools_sort]} - \
  -@ "${threads}" \
  -o "${sample}".sorted.bam
  # Index BAM
  ${programs_array[samtools_index]} "${sample}".sorted.bam
  # Run stringtie on alignments
  # Uses "-B" option to output tables intended for use in Ballgown
  # Uses "-e" option; recommended when using "-B" option.
  # Limits analysis to only reads alignments matching reference.
  "${programs_array[stringtie]}" "${sample}".sorted.bam \
  -p "${threads}" \
  -o "${sample}".gtf \
  -G "${genome_gff}" \
  -C "${sample}.cov_refs.gtf" \
  -B \
  -e
  gtf_lines=$(wc -l < "${sample}".gtf )
  if [ "${gtf_lines}" -gt 2 ]; then
    echo "$(pwd)/${sample}.gtf" >> ../"${gtf_list}"
  fi
  # Delete unneeded SAM files
  rm ./*.sam
  # Generate checksums
  for file in *
  do
    md5sum "${file}" >> ${sample}_checksums.md5
  done
  # Move up to orig. working directory
  cd ../
done
find . -name "*sorted.bam" > sorted_bams.list
${programs_array[samtools_merge]} \
-b sorted_bams.list \
${merged_bam} \
--threads ${threads}
${programs_array[samtools_index]} ${merged_bam}
"${programs_array[stringtie]}" --merge \
"${gtf_list}" \
-p "${threads}" \
-G "${genome_gff}" \
-o "${genome_index_name}".stringtie.gtf
while read -r line
do
  echo ${line##*/} ${line}
done < gtf_list.txt >> prepDE-sample_list.txt
python3 "${programs_array[prepDE]}" --input=prepDE-sample_list.txt
rm "${genome_index_name}"*.ht2
find . -maxdepth 1 -type f -exec md5sum {} + \
| tee --append checksums.md5
if [[ "${#programs_array[@]}" -gt 0 ]]; then
  echo "Logging program options..."
  for program in "${!programs_array[@]}"
  do
    {
    echo "Program options for ${program}: "
    echo ""
    # Handle samtools help menus
    if [[ "${program}" == "samtools_index" ]] \
    || [[ "${program}" == "samtools_sort" ]] \
    || [[ "${program}" == "samtools_view" ]]
    then
      ${programs_array[$program]}
    # Handle DIAMOND BLAST menu
    elif [[ "${program}" == "diamond" ]]; then
      ${programs_array[$program]} help
    # Handle NCBI BLASTx menu
    elif [[ "${program}" == "blastx" ]]; then
      ${programs_array[$program]} -help
    # Handle StringTie prepDE script
    elif [[ "${program}" == "prepDE" ]]; then
      python3 ${programs_array[$program]} -h
    fi
    ${programs_array[$program]} -h
    echo ""
    echo ""
    echo "----------------------------------------------"
    echo ""
    echo ""
  } &>> program_options.log || true
    # If MultiQC is in programs_array, copy the config file to this directory.
    if [[ "${program}" == "multiqc" ]]; then
      cp --preserve ~/.multiqc_config.yaml multiqc_config.yaml
    fi
  done
  echo "Finished logging programs options."
  echo ""
fi
echo "Logging system $PATH..."
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log
echo "Finished logging system $PATH."
