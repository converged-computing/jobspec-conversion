#!/bin/bash
#FLUX: --job-name=s1_align.sl
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --urgency=16

export OPENBLAS_MAIN_FREE='1'

echo align start $(date "+%H:%M:%S %d-%m-%Y")
source ~/NeSI_GATK/gatk_references.sh
DIR=$1
sample=$2
RG=$(head -1 $DIR/input/rg_info.txt)
export OPENBLAS_MAIN_FREE=1
i=$SLURM_ARRAY_TASK_ID
module load BWA/0.7.12-goolf-1.5.14
module load SAMtools/1.2-goolf-1.5.14
if ! srun bwa mem -M -t ${SLURM_JOB_CPUS_PER_NODE} -R ${RG} $REF $DIR/temp/R1_${i}.fastq.gz $DIR/temp/R2_${i}.fastq.gz 2> $DIR/logs/${sample}_${i}_bwa.log | samtools view -bh - > $DIR/temp/${sample}_aligned_reads_${i}.bam ; then
        echo "BWA failed"
	echo 'align failed' > $DIR/final/failed.txt
        exit 1
fi
rm $DIR/temp/R1_${i}.fastq.gz $DIR/temp/R2_${i}.fastq.gz
echo align finish $(date "+%H:%M:%S %d-%m-%Y")
