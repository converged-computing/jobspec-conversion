#!/bin/bash
#FLUX: --job-name=fis
#FLUX: --queue=phillips
#FLUX: -t=54000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load plink bedtools samtools easybuild  GCC/4.9.3-2.25  OpenMPI/1.10.2 HTSlib/1.6
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
cd sim30rep #then others
listfiles=(d*/*[015].vcf)
VCFI=${listfiles[$SLURM_ARRAY_TASK_ID]}
VCF=${VCFI/vcf/MAF.vcf}
cut -f1-29 $VCFI |vcftools --vcf - --maf 0.05 --stdout --recode --recode-INFO-all  > $VCF
bgzip -c $VCF > $VCF.gz
tabix -p vcf $VCF.gz
rm -f ${VCF/.vcf/.FIS}
r
while read window; do
	echo $window > ${VCF}.TARGET.bed
	sed -i "s/ /:/" ${VCF}.TARGET.bed
	sed -i "s/ /-/" ${VCF}.TARGET.bed
popStats --type GT --target 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19 --file $VCF.gz  --region $(cat ${VCF}.TARGET.bed) > ${VCF}.TMP.FIS
awk '{ sum += $9 } END { if (NR > 0) print sum / NR }' ${VCF}.TMP.FIS >${VCF}.TMP.FIS.SUM
	echo $window > ${VCF}.WINDOW.bed
	sed -i "s/ /\t/g" ${VCF}.WINDOW.bed
	paste -d'\t' ${VCF}.WINDOW.bed ${VCF}.TMP.FIS.SUM >>${VCF/.vcf/.FIS}
done < /projects/phillipslab/ateterina/slim/worms_snakemake/ref.windows.40kb.bed
rm ${VCF}.TMP*
rm $VCF.gz*
