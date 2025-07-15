#!/bin/bash
#FLUX: --job-name=GATK_PP
#FLUX: -t=1296000
#FLUX: --priority=16

source ~/.bashrc
source ../envar.sh
module add Java/1.7.0_21
module add R/3.0.2
input=(
$(cat bam.files)
)
java -Xmx5000M \
    -jar ${GATK}/GenomeAnalysisTK.jar  \
    -T RealignerTargetCreator \
    -R $MM10 \
    -I ${input[$SLURM_ARRAY_TASK_ID]} \
    -nt $SLURM_JOB_CPUS_PER_NODE\
    -o ${input[$SLURM_ARRAY_TASK_ID]}.intervals
java -Xmx4000M -verbose\
    -jar ${GATK}/GenomeAnalysisTK.jar  \
    -R $MM10\
    -T IndelRealigner \
    -targetIntervals ${input[$SLURM_ARRAY_TASK_ID]}.intervals\
    -I ${input[$SLURM_ARRAY_TASK_ID]} \
    -o ${input[$SLURM_ARRAY_TASK_ID]}.ir.bam
java -Xmx5000M\
    -jar ${GATK}/GenomeAnalysisTK.jar  \
    -R $MM10\
    -T BaseRecalibrator\
    -I ${input[$SLURM_ARRAY_TASK_ID]}.ir.bam\
    -knownSites $SNP\
    -o ${input[$SLURM_ARRAY_TASK_ID]}.grp\
    -nct $SLURM_JOB_CPUS_PER_NODE
java -Xmx5000M -Djava.io.tmpdir=$GLOBALSCRATCH/tmp \
    -jar ${GATK}/GenomeAnalysisTK.jar  \
    -T PrintReads\
    -R $MM10\
    -I ${input[$SLURM_ARRAY_TASK_ID]}.ir.bam \
    -BQSR ${input[$SLURM_ARRAY_TASK_ID]}.grp\
    -nct $SLURM_JOB_CPUS_PER_NODE\
    -compress 6\
    -o ${input[$SLURM_ARRAY_TASK_ID]}.ir.bqsr.bam
