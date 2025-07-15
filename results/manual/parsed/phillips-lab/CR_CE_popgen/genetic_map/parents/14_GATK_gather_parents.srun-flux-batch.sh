#!/bin/bash
#FLUX: --job-name=parents
#FLUX: -c=5
#FLUX: --queue=phillips
#FLUX: -t=180000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
tmp="/projects/phillipslab/ateterina/tmp"
GATK="/projects/phillipslab/ateterina/scripts/gatk-4.1.4.1/gatk"
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
$GATK --java-options "-Xmx15g -Xms10g" \
	          GatherVcfs \
            -I Parents_full_output.I.vcf \
            -I Parents_full_output.II.vcf \
            -I Parents_full_output.III.vcf \
            -I Parents_full_output.IV.vcf \
            -I Parents_full_output.V.vcf \
            -I Parents_full_output.X.vcf \
	         --OUTPUT Parents_raw.vcf.vcf
mv CR_WILD_population_raw* /projects/phillipslab/ateterina/CR_map/FINAL/Parents/
        #java -Xmx30g -jar $EBROOTGATK/GenomeAnalysisTK.jar -R $ref -T GenotypeGVCFs -O CR_bwa_GATK.BEST.invar.vcf -allSites \
