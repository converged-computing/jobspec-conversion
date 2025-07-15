#!/bin/bash
#FLUX: --job-name=20220826-cvir-larvae_zygote-RNAseq-fastp_trimming
#FLUX: --queue=coenv
#FLUX: -t=864000
#FLUX: --priority=16

fastq_pattern='*.fastq.gz'
R1_fastq_pattern='*R1*.fastq.gz'
R2_fastq_pattern='*R2*.fastq.gz'
threads=40
raw_reads_dir=/gscratch/scrubbed/samwhite/data/C_virginica/BSseq/
trimmed_checksums=trimmed-fastq-checksums.md5
raw_fastq_checksums=raw-fastq-checksums.md5
input_fastq_checksums=input-fastq-checksums.md5
fastp=/gscratch/srlab/programs/fastp-0.20.0/fastp
multiqc=/gscratch/srlab/programs/anaconda3/bin/multiqc
fastq_array_R1=()
fastq_array_R2=()
R1_names_array=()
R2_names_array=()
declare -A programs_array
programs_array=(
[fastp]="${fastp}" \
[multiqc]="${multiqc}"
)
set -e
module load intel-python3_2017
timestamp=$(date +%Y%m%d)
for first_run_fastq in "${raw_reads_dir}"2018OALarvae_DNAm_discovery/${fastq_pattern}
do
  echo "Generating checksums for raw input FastQs..."
  # Strip full path to just get filename.
  first_run_fastq_name="${first_run_fastq##*/}"
  # Determine MD5 checksum
  md5sum "${first_run_fastq}" | tee --append "${raw_fastq_checksums}"
  echo ""
  # Rsync FastQ
  echo "Rsyncing ${first_run_fastq} to working directory."
  rsync -aP "${first_run_fastq}" .
  echo "Finished rsyncing ${first_run_fastq}."
  echo ""
  # Process second run and concatenate with corresponding FastQ from first run
  # Do NOT quote fastq_pattern variable
  for second_run_fastq in "${raw_reads_dir}"2018OALarvae_DNAm_discovery/second_lane/${fastq_pattern}
  do
    # Strip full path to just get filename.
    second_run_fastq_name="${second_run_fastq##*/}"
    # Concatenate FastQs with same filenames
    if [[ "${first_run_fastq_name}" == "${second_run_fastq_name}" ]]; then
      echo "Concatenating ${first_run_fastq_name} with ${second_run_fastq} to ${first_run_fastq_name}"
      echo ""
      cat "${second_run_fastq}" >> "${first_run_fastq_name}"
    fi
  done
  echo "Generating checksums for concatenated FastQs..."
  md5sum "${first_run_fastq_name}" | tee --append "${input_fastq_checksums}"
  echo ""
done
for second_run_fastq in "${raw_reads_dir}"2018OALarvae_DNAm_discovery/${fastq_pattern}
do
  echo "Generating checksums for second run raw input FastQs..."
    # Determine MD5 checksum
    md5sum "${second_run_fastq}" | tee --append "${raw_fastq_checksums}"
    echo ""
done
echo ""
echo "FastQ concatenation complete."
echo ""
for fastq in ${R1_fastq_pattern}
do
  fastq_array_R1+=("${fastq}")
  # Use parameter substitution to remove all text up to and including last "." from
  # right side of string.
  R1_names_array+=("${fastq%%.*}")
done
for fastq in ${R2_fastq_pattern}
do
  fastq_array_R2+=("${fastq}")
  # Use parameter substitution to remove all text up to and including last "." from
  # right side of string.
  R2_names_array+=(${fastq%%.*})
done
echo "Beginning fastp trimming."
echo ""
for index in "${!fastq_array_R1[@]}"
do
  R1_sample_name="${R1_names_array[index]}"
  R2_sample_name="${R2_names_array[index]}"
  ${fastp} \
  --in1 ${fastq_array_R1[index]} \
  --in2 ${fastq_array_R2[index]} \
  --detect_adapter_for_pe \
  --thread ${threads} \
  --html "${R1_sample_name}".fastp-trim."${timestamp}".report.html \
  --json "${R1_sample_name}".fastp-trim."${timestamp}".report.json \
  --out1 "${R1_sample_name}".fastp-trim."${timestamp}".fq.gz \
  --out2 "${R2_sample_name}".fastp-trim."${timestamp}".fq.gz
  # Generate md5 checksums for newly trimmed files
  {
      md5sum "${R1_sample_name}".fastp-trim."${timestamp}".fq.gz
      md5sum "${R2_sample_name}".fastp-trim."${timestamp}".fq.gz
  } >> "${trimmed_checksums}"
  # Remove original FastQ files
  echo ""
  echo " Removing ${fastq_array_R1[index]} and ${fastq_array_R2[index]}."
  rm "${fastq_array_R1[index]}" "${fastq_array_R2[index]}"
done
echo "fastp trimming complete."
echo ""
echo "Beginning MultiQC..."
echo ""
${multiqc} .
echo ""
echo "MultiQC complete."
echo ""
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
fi
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log
