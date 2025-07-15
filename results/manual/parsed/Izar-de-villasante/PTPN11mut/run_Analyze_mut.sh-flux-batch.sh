#!/bin/bash
#FLUX: --job-name=mut_gatk_ptpn11
#FLUX: -N=3
#FLUX: -c=32
#FLUX: -t=169800
#FLUX: --urgency=16

echo "Starting at $(date)"
echo "Job submitted to the ${SLURM_JOB_PARTITION} partition, the default partition on ${SLURM_CLUSTER_NAME}"
echo "Job name: ${SLURM_JOB_NAME}, Job ID: ${SLURM_JOB_ID}"
echo "  I have ${SLURM_CPUS_ON_NODE} CPUs on compute node $(hostname)"
pwd
cd $SLURM_SUBMIT_DIR
n=$(echo "scale=2 ; ${SLURM_ARRAY_TASK_ID}/100" | bc) 
data_raw="/mnt/beegfs/idevillasante/Projects/PTPN11/90-612199113/00_fastq/"
fastq_dir="/mnt/beegfs/idevillasante/Projects/PTPN11/mut/fastq/"
bam_dir="/mnt/beegfs/idevillasante/Projects/PTPN11/mut/bam/"
name="PTPN11_sub$n"
input="${bam_dir}${name}.bam"
module load spack
module load Java
module load bwa
echo $n
seqtk sample -s12345 ${data_raw}PTPN11-SeSaM-Library_R1_001.fastq.gz $n > ${fastq_dir}${name}_R1.fastq
seqtk sample -s12345 ${data_raw}PTPN11-SeSaM-Library_R2_001.fastq.gz $n > ${fastq_dir}${name}_R2.fastq
bwa mem -M -t 32 -R "@RG\tID:ptpn11amp\tSM:ptpn11amp\tPL:ILLUMINA" ./refgene/gene.fasta ${fastq_dir}${name}_R1.fastq ${fastq_dir}${name}_R2.fastq > "${bam_dir}${name}.bam"
gatk --java-options "-Xmx64G" AnalyzeSaturationMutagenesis -I $input  -R /mnt/beegfs/idevillasante/Projects/PTPN11/refgene/gene.fasta --orf 1-1782 -O "/mnt/beegfs/idevillasante/Projects/PTPN11/mut/out/${name}"
Rscript -e "rmarkdown::render('./R/codons2.Rmd',params=list(prefix = '../data-raw/mut4/PTPN11_trimmed',gene_file='../data-raw/gene.fasta'))"
sstat  -j   $SLURM_JOB_ID.batch   --format=JobID,MaxVMSize
seff $SLURM_JOB_ID.batch
