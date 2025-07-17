#!/bin/bash
#FLUX: --job-name=align
#FLUX: -c=10
#FLUX: --urgency=16

set -e ### stops bash script if line ends with error
echo ${HOSTNAME} ${SLURM_ARRAY_TASK_ID}
module purge
module load GCC/9.3.0 \
            SAMtools/1.10 \
            HISAT2/2.2.1
nameArray=(
            her3_38aa_1_24hpf \
            her3_38aa_1_72hpf \
            her3_38aa_2_24hpf \
            her3_38aa_2_72hpf \
            her3_38aa_3_24hpf \
            her3_38aa_3_72hpf \
            her3-MO_1_24hpf \
            her3-MO_2_24hpf \
            her3-MO_3_24hpf \
            mm-MO_1_24hpf \
            mm-MO_2_24hpf \
            mm-MO_3_24hpf \
            WIK_1_24hpf \
            WIK_1_72hpf \
            WIK_2_24hpf \
            WIK_2_72hpf \
            WIK_3_24hpf \
            WIK_3_72hpf
            )
baseName=${nameArray[${SLURM_ARRAY_TASK_ID}]}
inputPath=/home/gdkendalllab/lab/raw_data/fastq/2021_10_07
R1=$(ls ${inputPath}/${baseName}/*R1*fastq.gz | \
        perl -pe 's/\n/,/' | \
        perl -pe 's/,$//')
R2=$(ls ${inputPath}/${baseName}/*R2*fastq.gz | \
        perl -pe 's/\n/,/' | \
        perl -pe 's/,$//')
hisat2 \
  -x /home/gdkendalllab/lab/references/hisat2/danRer11_plusERCC \
  -1 ${R1} \
  -2 ${R2} \
  -k 1 \
  -p 8 \
  --summary-file output/aligned/${baseName}Summary.txt | \
  samtools fixmate -@ 4 -m - - | \
  samtools sort -@ 4 -O BAM | \
  samtools markdup -@ 4 -r - - | \
  samtools view -@ 4 -f 2 -b - \
    > output/aligned/${baseName}.bam
samtools index output/aligned/${baseName}.bam
