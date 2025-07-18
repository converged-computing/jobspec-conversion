#!/bin/bash
#FLUX: --job-name=insert
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load r/intel/3.3.2
module load picard/2.8.2
sample=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" /scratch/cr1636/ATAC_Ciona_sana_claudia/bam_610151820_18hpfnew/lib.txt)
RUNDIR=/scratch/cr1636/ATAC_Ciona_sana_claudia/bam_610151820_18hpfnew/
cd $RUNDIR
java -jar /share/apps/picard/2.8.2/picard-2.8.2.jar CollectInsertSizeMetrics INPUT=${sample}_q30_rmdup_KhM0_sorted.bam OUTPUT=insertSize/${sample}.txt HISTOGRAM_FILE=insertSize/${sample}.pdf
exit 0;
