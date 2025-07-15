#!/bin/bash
#FLUX: --job-name=20210312_cbai-vs-copi_diamond_blastx
#FLUX: --queue=srlab
#FLUX: -t=1728000
#FLUX: --priority=16

reads_dir=/gscratch/srlab/sam/data/C_bairdi/RNAseq
dmnd=/gscratch/srlab/sam/data/C_opilio/blastdbs/GCA_016584305.1_ASM1658430v1_protein.dmnd
declare -A programs_array
programs_array=(
[diamond]="/gscratch/srlab/programs/diamond-0.9.29/diamond"
)
fastq_array=(${reads_dir}/*fastp-trim*.fq.gz)
set -e
module load intel-python3_2017
for fastq in "${!fastq_array[@]}"
do
  # Remove path from transcriptome using parameter substitution
  fastq_name="${fastq_array[$fastq]##*/}"
  # Generate checksums for reference
  echo ""
  echo "Generating checksum for ${fastq_array[$fastq]}."
  md5sum "${fastq_array[$fastq]}">> fastq.checksums.md5
  echo "Completed checksum for ${fastq_array[$fastq]}."
  echo ""
  # Run DIAMOND with blastx
  # Output format 6 query only returns a single query ID per match
  # block-size and index-chunks are computing resource optimatization paraeters
  ${programs_array[diamond]} blastx \
  --db ${dmnd} \
  --query "${fastq_array[$fastq]}" \
  --out "${fastq_name}".blastx.outfmt6-query \
  --outfmt 6 qseqid \
  --evalue 1e-4 \
  --max-target-seqs 1 \
  --max-hsps 1 \
  --block-size 15.0 \
  --index-chunks 4
done
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
