#!/bin/bash
#FLUX: --job-name=20231206_pycno2022_fastp
#FLUX: --queue=srlab
#FLUX: -t=864000
#FLUX: --priority=16

threads=40
trimmed_checksums=trimmed_fastq_checksums.md5
raw_reads_dir=/gscratch/srlab/graceac9/data/pycno/RNAseq/summer2022
fastq_checksums=raw_fastq_checksums.md5
fastp=/gscratch/srlab/programs/fastp-0.20.0/fastp
multiqc=/gscratch/srlab/programs/anaconda3/bin/multiqc
fastq_array_R1=()
fastq_array_R2=()
declare -A programs_array
programs_array=(
[fastp]="${fastp}" \
[multiqc]="${multiqc}"
)
set -e
module load intel-python3_2017
timestamp=$(date +%Y%m%d)
rsync --archive --verbose \
"${raw_reads_dir}"/PSC*.fastq.gz .
for fastq in PSC*R1*.fastq.gz
do
  fastq_array_R1+=("${fastq}")
done
for fastq in PSC*R2*.fastq.gz
do
  fastq_array_R2+=("${fastq}")
done
for index in "${!fastq_array_R1[@]}"
do
  # Remove .fastq.gz from end of file names
  R1_sample_name=$(echo "${fastq_array_R1[index]}" | sed 's/.fq.gz//')
  R2_sample_name=$(echo "${fastq_array_R2[index]}" | sed 's/.fq.gz//')
  # Get sample name without R1/R2 labels
  sample_name=$(echo "${fastq_array_R1[index]}" | sed 's/_[12].*//')
  echo ""
  echo "fastp started on ${sample_name} FastQs."
  # Run fastp
  # Specifies reports in HTML and JSON formats
  ${fastp} \
  --in1 ${fastq_array_R1[index]} \
  --in2 ${fastq_array_R2[index]} \
  --detect_adapter_for_pe \
  --thread ${threads} \
  --html "${sample_name}".fastp-trim."${timestamp}".report.html \
  --json "${sample_name}".fastp-trim."${timestamp}".report.json \
  --out1 "${R1_sample_name}".fastp-trim."${timestamp}".fq.gz \
  --out2 "${R2_sample_name}".fastp-trim."${timestamp}".fq.gz
  echo "fastp completed on ${sample_name} FastQs"
  echo ""
  # Generate md5 checksums for newly trimmed files
  {
  md5sum "${R1_sample_name}".fastp-trim."${timestamp}".fq.gz
  md5sum "${R2_sample_name}".fastp-trim."${timestamp}".fq.gz
  } >> "${trimmed_checksums}"
  # Create MD5 checksum for reference
  {
    md5sum "${fastq_array_R1[index]}"
    md5sum "${fastq_array_R2[index]}"
  }  >> ${fastq_checksums}
  # Remove original FastQ files
  rm "${fastq_array_R1[index]}" "${fastq_array_R2[index]}"
done
${programs_array[multiqc]} .
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
{
  date
  echo ""
  echo "System PATH for $SLURM_JOB_ID"
  echo ""
  printf "%0.s-" {1..10}
  echo "${PATH}" | tr : \\n
} >> system_path.log
echo "Finished logging system PATH"
