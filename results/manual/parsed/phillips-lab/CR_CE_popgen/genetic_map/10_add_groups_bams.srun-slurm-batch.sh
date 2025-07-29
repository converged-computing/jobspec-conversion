#!/bin/bash
#SBATCH --job-name=map_RAD
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --array=0-383

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bwa samtools easybuild GATK
ref_CHR="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
outd="/projects/phillipslab/ateterina/CR_map/FINAL"
recalibr="/projects/phillipslab/ateterina/CR_map/FINAL/Parents/Parents_0011_filt_snps_ok.vcf"
picard="/projects/phillipslab/ateterina/scripts/picard/build/libs/picard.jar"
cd $outd/stacks/BAMS2
LISTFILES=(*TMP.bam)
file=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
java -Xmx2g -jar $picard AddOrReplaceReadGroups I=$file O=${file/.TMP/} RGPL=illumina RGLB=${file/.TMP.bam/} RGPU=NONE RGSM=${file/.TMP.bam/};
java -Xmx5g -jar $picard BuildBamIndex INPUT=${file/.TMP/};
