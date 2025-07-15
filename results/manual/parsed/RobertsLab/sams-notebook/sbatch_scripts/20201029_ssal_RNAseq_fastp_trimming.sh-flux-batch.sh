#!/bin/bash
#FLUX: --job-name=202001029_ssal_RNAseq_fastp_trimming
#FLUX: --queue=coenv
#FLUX: -t=864000
#FLUX: --priority=16

threads=27
trimmed_checksums=trimmed_fastq_checksums.md5
raw_reads_dir=/gscratch/srlab/sam/data/S_salar/RNAseq/
fastq_checksums=raw_fastq_checksums.md5
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
rsync --archive --verbose \
"${raw_reads_dir}"*.gz .
for fastq in *_1.fastq.gz
do
  fastq_array_R1+=("${fastq}")
	R1_names_array+=("$(echo "${fastq}" | awk 'BEGIN {FS = "[._]";OFS = "_"} {print $1, $2, $3, $4, $5}')")
done
for fastq in *_2.fastq.gz
do
  fastq_array_R2+=("${fastq}")
	R2_names_array+=("$(echo "${fastq}" |awk 'BEGIN {FS = "[._]";OFS = "_"} {print $1, $2, $3, $4, $5}')")
done
for fastq in *.gz
do
  echo "${fastq}" >> input.fastq.list.txt
	md5sum >> ${fastq_checksums}
done
for index in "${!fastq_array_R1[@]}"
do
  R1_sample_name=$(echo "${R1_names_array[index]}")
	R2_sample_name=$(echo "${R2_names_array[index]}")
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
	rm "${fastq_array_R1[index]}" "${fastq_array_R2[index]}"
done
${multiqc} .
for program in "${!programs_array[@]}"
do
	{
  echo "Program options for ${program}: "
	echo ""
	${programs_array[$program]} -h
	echo ""
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo ""
} &>> program_options.log || true
  # If MultiQC is in programs_array, copy the config file to this directory.
  if [[ "${program}" == "multiqc" ]]; then
  	cp --preserve ~/.multiqc_config.yaml "${timestamp}_multiqc_config.yaml"
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
while read -r line
do
	echo ""
	echo "Removing ${line}"
	rm "${line}"
done < input.fastq.list.txt
