#!/bin/bash
#FLUX: --job-name=20201103_ssal_RNAseq_hisat2_alignment
#FLUX: --queue=coenv
#FLUX: -t=864000
#FLUX: --priority=16

threads=27
fastq_checksums=fastq_checksums.md5
fastq_dir="/gscratch/srlab/sam/data/S_salar/RNAseq/"
genome_fasta="/gscratch/srlab/sam/data/S_salar/genomes/GCF_000233375.1_ICSASG_v2_genomic.fa"
genome_index_name="GCF_000233375.1_ICSASG_v2"
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2="${hisat2_dir}/hisat2"
hisat2_build="${hisat2_dir}/hisat2-build"
samtools="/gscratch/srlab/programs/samtools-1.10/samtools"
fastq_array_R1=()
fastq_array_R2=()
names_array=()
declare -A programs_array
programs_array=(
[hisat2]="${hisat2}" \
[hisat2-build]="${hisat2_build}"
[samtools_index]="${samtools} index" \
[samtools_sort]="${samtools} sort" \
[samtools_view]="${samtools} view"
)
set -e
module load intel-python3_2017
timestamp=$(date +%Y%m%d)
for fastq in "${fastq_dir}"*_1.fastp-trim.20201029.fq.gz
do
    fastq_array_R1+=("${fastq}")
  # Create array of sample names
  ## Uses parameter substitution to strip leading path from filename
  ## Uses awk to parse out sample name from filename
  names_array+=($(echo "${fastq#${fastq_dir}}" | awk -F"[_]" '{print $1 "_" $2}'))
done
for fastq in "${fastq_dir}"*_2.fastp-trim.20201029.fq.gz
do
  fastq_array_R2+=("${fastq}")
done
"${programs_array[hisat2-build]}" \
"${genome_fasta}" \
"${genome_index_name}" \
-p "${threads}" \
2> hisat2_build.err
for index in "${!fastq_array_R1[@]}"
do
  # Get current sample name
  sample_name=$(echo "${names_array[index]}")
  # Run Hisat2
  # Sets --dta which tailors output for downstream transcriptome assemblers (e.g. Stringtie)
  # Sets --new-summary option for use with MultiQC
  "${programs_array[hisat2]}" \
  -x "${genome_index_name}" \
  --dta \
  --new-summary \
  -1 "${fastq_array_R1[index]}" \
  -2 "${fastq_array_R2[index]}" \
  -S "${sample_name}".sam \
  2> "${sample_name}"_hisat2.err
  ${programs_array[samtools_view]} \
  -@ "${threads}" \
  -Su "${sample_name}".sam \
  | ${programs_array[samtools_sort]} - \
  -@ "${threads}" \
  -o "${sample_name}".sorted.bam
  # Index sorted BAM file
  ${programs_array[samtools_index]} "${sample_name}".sorted.bam
done
for fastq in "${fastq_dir}"*fastp-trim.20201029.fq.gz
do
  echo "${fastq#${fastq_dir}}" >> fastq.list.txt
  md5sum "${fastq}" >> ${fastq_checksums}
done
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
