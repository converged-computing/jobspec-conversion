#!/bin/bash
#SBATCH --job-name=GATK
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --partition=phillips
#SBATCH --array=0-18

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
tmp="/projects/phillipslab/ateterina/tmp"
GATK="/projects/phillipslab/ateterina/scripts/gatk-4.1.4.1/gatk"
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
LISTFILES=(*re.bam)
file=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
java -Xmx5g -jar $EBROOTGATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -R $ref -I $file -o ${file/.re.bam/.intervals} ;
java -Xmx5g -Djava.io.tmpdir=$tmp  -jar $EBROOTGATK/GenomeAnalysisTK.jar -T IndelRealigner -I $file -R $ref -targetIntervals ${file/.re.bam/.intervals} -o ${file/.re.bam/.ind.bam};
$GATK --java-options "-Xmx5g -Xms5g" HaplotypeCaller -R $ref -I ${file/.re.bam/.ind.bam}  -O ${file/.re.bam/.raw.new.g.vcf} -ERC GVCF;
