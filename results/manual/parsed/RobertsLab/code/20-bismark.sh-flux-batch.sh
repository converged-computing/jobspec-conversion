#!/bin/bash
#FLUX: --job-name=BISMARK
#FLUX: --queue=coenv
#FLUX: -t=2592000
#FLUX: --priority=16

set -e
reads_dir=""
genome_dir=""
deduplicate=""
subset="-u 0"
[ -z ${deduplicate} ] \
&& { echo "The deduplicate variable is not defined. Please edit the SBATCH script and add y or n to deduplicate variable."; exit 1; }
[ -z ${genome_dir} ] \
&& { echo "The bisulfite genome directory path has not been set. Please edit the SBATCH script."; exit 1; }
[ -z ${reads_dir} ] \
&& { echo "The reads directory path has not been set. Please edit the SBATCH script."; exit 1; }
wd=$(pwd)
bismark_dir="/gscratch/srlab/programs/Bismark-0.21.0_dev"
bowtie2_dir="/gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64/"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
threads="28"
reads_list="input_fastqs.txt"
R1=""
R2=""
R1_array=()
R2_array=()
for fastq in ${reads_dir}/*.fq.gz
do
  echo ${fastq##*/} >> ${reads_list}
done
set +e
grep "_R2_" ${reads_list}
paired=$?
set -e
num_files=$(wc -l < ${reads_list})
fastq_even_odd=$(echo $(( ${num_files} % 2 )) )
R1_array=(${reads_dir}/*_R1_*.fq.gz)
R1=$(echo ${R1_array[@]} | tr " " ",")
if [[ ${paired} -eq 0 ]]; then
  # Evaluate if FastQs have corresponding partner (i.e. R1 and R2 files)
  # Evaluated on even/odd number of files.
  if [[ ${fastq_even_odd} -ne 0 ]]; then
    { echo "Missing at least one FastQ pair from paired-end FastQ set."; \
      echo "Please verify input FastQs all have an R1 and corresponding R2 file.";
      exit 1; \
    }
  fi
  ## Save FastQ files to arrays
  R2_array=(${reads_dir}/*_R2_*.fq.gz)
  ## Send comma-delimited list of R2 FastQ to variable
  R2=$(echo ${R2_array[@]} | tr " " ",")
  # Run bismark using bisulftie-converted genome
  # Generates a set of BAM files as outputs
  # Records stderr to a file for easy viewing of Bismark summary info
  ${bismark_dir}/bismark \
  --path_to_bowtie2 ${bowtie2_dir} \
  --genome ${genome_dir} \
  --samtools_path=${samtools} \
  --non_directional \
  ${subset} \
  -p ${threads} \
  -1 ${R1} \
  -2 ${R2} \
  2> bismark_summary.txt
else
  # Run Bismark single-end
  ${bismark_dir}/bismark \
  --path_to_bowtie2 ${bowtie2_dir} \
  --genome ${genome_dir} \
  --samtools_path=${samtools} \
  --non_directional \
  ${subset} \
  -p ${threads} \
  ${R1} \
  2> bismark_summary.txt
fi
if [ ${deduplicate} == "y"  ]; then
  # Sort Bismark BAM files by read names instead of chromosomes
  find *.bam \
  | xargs basename -s .bam \
  | xargs -I bam_basename \
  ${samtools} sort \
  --threads ${threads} \
  -n bam_basename.bam \
  -o bam_basename.sorted.bam
  if [ ${paired} -eq 0 ]; then
    # Deduplication
    find *sorted.bam \
    | xargs basename -s .bam \
    | xargs -I bam_basename \
    ${bismark_dir}/deduplicate_bismark \
    --paired \
    --samtools_path=${samtools} \
    bam_basename.bam
  else
    find *sorted.bam \
    | xargs basename -s .bam \
    | xargs -I bam_basename \
    ${bismark_dir}/deduplicate_bismark \
    --single \
    --samtools_path=${samtools} \
    bam_basename.bam
  fi
  # Methylation extraction
  # Extracts methylation info from deduplicated BAM files produced by Bismark
  # Options to created a bedgraph file, a cytosine coverage report, counts, remove spaces from names
  # and to use the "scaffolds" setting.
  ${bismark_dir}/bismark_methylation_extractor \
  --bedGraph \
  --cytosine_report \
  --genome_folder ${genome_dir} \
  --gzip
  --counts \
  --scaffolds \
  --remove_spaces \
  --multicore ${threads} \
  --buffer_size 75% \
  --samtools_path=${samtools} \
  *deduplicated.bam
  # Sort deduplicated BAM files
  find *deduplicated.bam \
  | xargs basename -s .bam \
  | xargs -I bam_basename \
  ${samtools} sort \
  --threads ${threads} \
  bam_basename.bam \
  -o bam_basename.sorted.bam
  # Index sorted files for IGV
  # The "-@ ${threads}" below specifies number of CPU threads to use.
  find *deduplicated.sorted.bam \
  | xargs -I sorted_bam \
  ${samtools} index \
  -@ ${threads} \
  sorted_bam
else
  # Methylation extraction
  # Extracts methylation info from BAM files produced by Bismark
  # Options to created a bedgraph file, a cytosine coverage report, counts, remove spaces from names
  # and to use the "scaffolds" setting.
  ${bismark_dir}/bismark_methylation_extractor \
  --bedGraph \
  --cytosine_report \
  --genome_folder ${genome_dir} \
  --gzip \
  --counts \
  --scaffolds \
  --remove_spaces \
  --multicore ${threads} \
  --buffer_size 75% \
  --samtools_path=${samtools} \
  *.bam
  # Sort BAM files
  find *.bam \
  | xargs basename -s .bam \
  | xargs -I bam_basename \
  ${samtools} sort \
  --threads ${threads} \
  -o bam_basename.sorted.bam
  # Index sorted files for IGV
  # The "-@ ${threads}" below specifies number of CPU threads to use.
  find *sorted.bam \
  | xargs -I sorted_bam \
  ${samtools} index \
  -@ ${threads} \
  sorted_bam
fi
${bismark_dir}/bismark2report
${bismark_dir}/bismark2summary
