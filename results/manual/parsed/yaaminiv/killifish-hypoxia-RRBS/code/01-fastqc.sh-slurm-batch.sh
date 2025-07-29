#!/bin/bash
#FLUX: --job-name=yrv_fastqc
#FLUX: -c=8
#FLUX: --queue=compute
#FLUX: -t=10800
#FLUX: --urgency=16

output_dir=/vortexfs1/scratch/yaamini.venkataraman/01-fastqc
checksums=fastq_checksums.md5
fastq_list=fastq_list.txt
raw_reads_dir=/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/
fastqc=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/fastqc
multiqc=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/multiqc
declare -A programs_array
programs_array=(
[fastqc]="${fastqc}" \
[multiqc]="${multiqc}"
)
set -e
module load python3/intel
rsync --archive --verbose \
"${raw_reads_dir}"190626_I114_FCH7TVNBBXY*.fq.gz .
fastq_array=(*.fq.gz)
fastqc_list=$(echo "${fastq_array[*]}")
${programs_array[fastqc]} \
--threads ${threads} \
--outdir ${output_dir} \
${fastqc_list}
echo "${fastqc_list}" | tr " " "\n" >> ${fastq_list}
while read -r line
do
	# Generate MD5 checksums for each input FastQ file
	echo "Generating MD5 checksum for ${line}."
	md5sum "${line}" >> "${checksums}"
	echo "Completed: MD5 checksum for ${line}."
	echo ""
	# Remove fastq files from working directory
	echo "Removing ${line} from directory"
	rm "${line}"
	echo "Removed ${line} from directory"
	echo ""
done < ${fastq_list}
${programs_array[multiqc]} .
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
  	cp --preserve ~/.multiqc_config.yaml .
  fi
done
