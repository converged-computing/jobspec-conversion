#!/bin/bash
#FLUX: --job-name=GATK4444
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
declare -a CHROMS=("I" "II" "III" "IV" "V" "X")
CHR=${CHROMS[$SLURM_ARRAY_TASK_ID]}
echo $CHR
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
samples=$(find . | sed 's/.\///' | grep -E 'H(.)*.raw.new.g.vcf$' | sed 's/^/-V /')
$GATK --java-options "-Xmx15g -Xms10g" GenomicsDBImport -R $ref \
--genomicsdb-workspace-path WILD_pop_database_${CHR} \
--tmp-dir $tmp -L ${CHR} --reader-threads 5 \
 $(echo $samples);
$GATK --java-options "-Xmx15g -Xms10g" GenotypeGVCFs \
       -R $ref \
       -V gendb://WILD_pop14_database_${CHR} \
       -O CR_WILD_full14_output.${CHR}.vcf \
       --include-non-variant-sites \
        -G StandardAnnotation \
        --only-output-calls-starting-in-intervals \
        --use-new-qual-calculator \
        -L ${CHR}
