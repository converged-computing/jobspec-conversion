#!/bin/bash
#FLUX: --job-name=Beagle_CE
#FLUX: -c=8
#FLUX: --queue=phillips
#FLUX: -t=720000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load samtools easybuild  GCC/4.9.3-2.25  OpenMPI/1.10.2 HTSlib/1.6
module load java easybuild GATK bedtools
tmp="/projects/phillipslab/ateterina/tmp"
beagle="/projects/phillipslab/ateterina/scripts/beagle.25Nov19.28d.jar"
vcf="CE_population_filt_snps_5-100_0.5_fin.vcf"
cd /projects/phillipslab/ateterina/CE_haw_subset/data/BAMS
if [ ! -f $vcf.gz ]; then
  bgzip -c $vcf >$vcf.gz
  tabix -p vcf $vcf.gz
fi
LISTFILES=(I II III IV V X)
chr=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
java -Xmx25g -Djava.io.tmpdir=$tmp -jar $beagle gt=$vcf.gz chrom=$chr out=${vcf/.vcf/.noimp2}.$chr impute=false ne=10000 window=10.0 overlap=4.0 iterations=12 nthreads=8 burnin=6;
