#!/bin/bash
#FLUX: --job-name=20230426-pgen-fastqc-fastp-multiqc-RNAseq
#FLUX: --queue=srlab
#FLUX: -t=432000
#FLUX: --urgency=16

https://robertslab.github.io/sams-notebook/2022/03/23/Differential-Gene-Expression-P.generosa-DGE-Between-Tissues-Using-Nextlow-NF-Core-RNAseq-Pipeline-on-Mox.html
fastq_pattern='*.fq.gz'
R1_fastq_pattern='*val_1.fq.gz'
R2_fastq_pattern='*val_2.fq.gz'
threads=40
trimmed_checksums=trimmed_fastq_checksums.md5
fastq_checksums=input_fastq_checksums.md5
output_dir=$(pwd)
reads_dir=/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq/
raw_fastqs_array=()
R1_names_array=()
R2_names_array=()
fastp=/gscratch/srlab/programs/fastp.0.23.1
fastqc=/gscratch/srlab/programs/fastqc_v0.11.9/fastqc
multiqc=/gscratch/srlab/programs/anaconda3/bin/multiqc
declare -A programs_array
programs_array=(
[fastqc]="${fastqc}"
[fastp]="${fastp}" \
[multiqc]="${multiqc}"
)
set -e
module load intel-python3_2017
timestamp=$(date +%Y%m%d)
echo ""
echo "Transferring files via rsync..."
rsync --archive --verbose \
"${reads_dir}"${fastq_pattern} .
echo ""
echo "File transfer complete."
echo ""
raw_fastqs_array=(${fastq_pattern})
raw_fastqc_list=$(echo "${raw_fastqs_array[*]}")
echo "Beginning FastQC on raw reads..."
echo ""
${programs_array[fastqc]} \
--threads ${threads} \
--outdir ${output_dir} \
${raw_fastqc_list}
echo "FastQC on raw reads complete!"
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
  R2_names_array+=("${fastq%%.*}")
done
for fastq in ${fastq_pattern}
do
  echo "Generating checksum for ${fastq}"
  md5sum "${fastq}" | tee --append ${fastq_checksums}
  echo ""
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
  --trim_poly_g \
  --trim_front1 20 \
  --trim_front2 20 \
  --thread ${threads} \
  --html "${R1_sample_name%%_*}".fastp-trim."${timestamp}".report.html \
  --json "${R1_sample_name%%_*}".fastp-trim."${timestamp}".report.json \
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
echo ""
echo "fastp trimming complete."
echo ""
trimmed_fastq_array=(*fastp-trim*.fq.gz)
trimmed_fastqc_list=$(echo "${trimmed_fastq_array[*]}")
echo "Beginning FastQC on trimmed reads..."
echo ""
${programs_array[fastqc]} \
--threads ${threads} \
--outdir ${output_dir} \
${trimmed_fastqc_list}
echo ""
echo "FastQC on trimmed reads complete!"
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
