#!/bin/bash
#FLUX: --job-name=manual_annotate
#FLUX: --queue=standard
#FLUX: -t=50400
#FLUX: --urgency=16

module purge
module load  htslib/1.10.2 bcftools/1.9 intel/18.0 intelmpi/18.0 parallel/20200322 R/3.6.3 samtools vcftools
popSet=all
method=PoolSNP
maf=001
mac=50
version=26April2023
wd=/scratch/aob2x/DESTv2_output_26April2023
snpEffPath=~/snpEff
cd ${wd}
 echo "concat"
   ls -d ${wd}/sub_bcf/dest.*.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz > \
   ${wd}/sub_bcf/vcf_order.genome
   vcf-concat \
   -f ${wd}/sub_bcf/vcf_order.genome \
   -s \
   |  \
   bgzip -c > ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz
   tabix -p vcf ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz
 echo "convert to vcf & annotate"
   bcftools view \
   --threads 10 \
   ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz | \
   java -jar ${snpEffPath}/snpEff.jar \
   eff \
   BDGP6.86 - > \
   ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf
echo "make GDS"
   Rscript --vanilla /scratch/aob2x/DESTv2/snpCalling/scatter_gather_annotate/vcf2gds.R ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf
echo "bgzip & tabix"
  bgzip -@20 -c ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf > ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf.gz
  tabix -p vcf ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf.gz
