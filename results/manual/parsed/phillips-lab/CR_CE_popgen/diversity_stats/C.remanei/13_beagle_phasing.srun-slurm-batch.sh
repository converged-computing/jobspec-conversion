#!/bin/bash
#SBATCH --job-name=Beag_CR
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=8-08:00:00
#SBATCH --array=0-5

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK bedtools
module load samtools easybuild  GCC/4.9.3-2.25  OpenMPI/1.10.2 HTSlib/1.6
tmp="/projects/phillipslab/ateterina/tmp"
beagle="/projects/phillipslab/ateterina/scripts/beagle.25Nov19.28d.jar"
vcf="/projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/CR_WILD_population14_filt_snps_5-100_0.5_fin.vcf"
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
if [ ! -f $vcf.gz ]; then
  bgzip -c $vcf >$vcf.gz
  tabix -p vcf $vcf.gz
fi
LISTFILES=(I II III IV V X)
chr=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
java -Xmx25g -Djava.io.tmpdir=$tmp -jar $beagle gt=$vcf.gz chrom=$chr out=${vcf/.vcf/.noimpi2}.$chr impute=false window=10.0 overlap=3.0 iterations=10 nthreads=8 burnin=5;
