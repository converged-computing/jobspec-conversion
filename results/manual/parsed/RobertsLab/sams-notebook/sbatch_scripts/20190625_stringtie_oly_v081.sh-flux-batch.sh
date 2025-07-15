#!/bin/bash
#FLUX: --job-name=oly_stringtie
#FLUX: --queue=srlab
#FLUX: -t=2160000
#FLUX: --priority=16

set -e
module load intel-python3_2017
date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo "${PATH}" | tr : \\n >> system_path.log
threads=27
genome_index_name="Olurida_v081"
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2="${hisat2_dir}/hisat2"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
stringtie="/gscratch/srlab/programs/stringtie-1.3.6.Linux_x86_64/stringtie"
genome_gff="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081/20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff"
genome_index_dir="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081"
fastq_dir="/gscratch/srlab/sam/data/O_lurida/RNAseq/"
gtf_list="gtf_list.txt"
fastq_array_R1=()
fastq_array_R2=()
names_array=()
rsync -av "${genome_index_dir}"/Olurida_v081*.ht2 .
for fastq in ${fastq_dir}*R1*.gz
do
  fastq_array_R1+=(${fastq})
done
for fastq in ${fastq_dir}*R2*.gz
do
  fastq_array_R2+=(${fastq})
done
for R1_fastq in ${fastq_dir}*R1*.gz
do
  names_array+=($(echo ${R1_fastq#${fastq_dir}} | awk -F"[_.]" '{print $1 "_" $5}'))
done
for fastq in ${fastq_dir}*.gz
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
  echo "${sample_name}.gtf" >> "${gtf_list}"
done
"${stringtie}" --merge \
"${gtf_list}" \
-p "${threads}" \
-G "${genome_gff}" \
-o "${genome_index_name}".stringtie.gtf
rm Olurida_v081*.ht2
rm *.sam
