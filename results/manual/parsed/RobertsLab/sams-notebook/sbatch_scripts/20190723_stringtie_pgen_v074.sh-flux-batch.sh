#!/bin/bash
#FLUX: --job-name=pgen_v074_stringtie
#FLUX: --queue=srlab
#FLUX: -t=2160000
#FLUX: --urgency=16

set -e
module load intel-python3_2017
date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo "${PATH}" | tr : \\n >> system_path.log
threads=28
genome_index_name="Pgenerosa_v074"
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2="${hisat2_dir}/hisat2"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
stringtie="/gscratch/srlab/programs/stringtie-1.3.6.Linux_x86_64/stringtie"
genome_gff="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v074_genome_snap02.all.renamed.putative_function.domain_added.gff"
genome_index_dir="/gscratch/srlab/sam/data/P_generosa/genomes"
fastq_dir="/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq/"
gtf_list="gtf_list.txt"
fastq_array_R1=()
fastq_array_R2=()
names_array=()
rsync -av "${genome_index_dir}"/Pgenerosa_v074*.ht2 .
for fastq in "${fastq_dir}"*R1*.gz
do
  fastq_array_R1+=("${fastq}")
done
for fastq in "${fastq_dir}"*R2*.gz
do
  fastq_array_R2+=("${fastq}")
done
for R1_fastq in "${fastq_dir}"*R1*.gz
do
  names_array+=($(echo "${R1_fastq#${fastq_dir}}" | awk -F"_" '{print $1}'))
done
for fastq in "${fastq_dir}"*.gz
do
  echo "${fastq#${fastq_dir}}" >> fastq.list.txt
done
for index in "${!fastq_array_R1[@]}"
do
  sample_name=$(echo "${names_array[index]}")
  "${hisat2}" \
  -x "${genome_index_name}" \
  --downstream-transcriptome-assembly \
  -1 "${fastq_array_R1[index]}" \
  -2 "${fastq_array_R2[index]}" \
  -S "${sample_name}".sam \
  2> "${sample_name}"_hisat2.err
  "${samtools}" view \
  -@ "${threads}" \
  -Su "${sample_name}".sam \
  | "${samtools}" sort - \
  -@ "${threads}" \
  -o "${sample_name}".sorted.bam
  "${samtools}" index "${sample_name}".sorted.bam
  "${stringtie}" "${sample_name}".sorted.bam \
  -p "${threads}" \
  -o "${sample_name}".gtf \
  -G "${genome_gff}" \
  -C "${sample_name}.cov_refs.gtf"
  gtf_lines=$(wc -l < ${sample_name}.gtf )
  if [ "${gtf_lines}" -gt 2 ]; then
    echo "${sample_name}.gtf" >> "${gtf_list}"
  fi
done
"${stringtie}" --merge \
"${gtf_list}" \
-p "${threads}" \
-G "${genome_gff}" \
-o "${genome_index_name}".stringtie.gtf
rm "${genome_index_name}"*.ht2
rm ./*.sam
