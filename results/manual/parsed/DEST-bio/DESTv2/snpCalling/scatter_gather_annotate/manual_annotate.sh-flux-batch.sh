#!/bin/bash
#FLUX: --job-name=wobbly-leg-8723
#FLUX: --priority=16

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
   # bcftools concat \
   # -O z \
   # ${wd}/sub_bcf/dest.*.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz \
   # -o ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.new.vcf.gz
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
   Rscript --vanilla /scratch/aob2x/DESTv2/snpCalling/scatter_gather_annotate/vcf2gds.R ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf
echo "bgzip & tabix"
  bgzip -@20 -c ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf > ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf.gz
  tabix -p vcf ${wd}/dest.${popSet}.${method}.${maf}.${mac}.${version}.norep.ann.vcf.gz
  #bcftools sort \
  #-o /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.sort.vcf.gz \
  #-O z \
  #/scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.vcf.gz
  #bgzip -d -c -@20 /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.vcf.gz > /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.vcf
  #cat /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.vcf | vcf-sort > /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.sort.vcf
  #bgzip -c -@20 /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.sort.vcf > /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.sort.vcf.gz
  # bcftools reheader \
  # -o /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.reheader.vcf.gz \
  # --threads 20 \
  # --fai /scratch/aob2x/DESTv2/snpCalling/scatter_gather_annotate/holo_dmel_6.12.fa.fai \
  # /scratch/aob2x/DESTv2_output_26April2023/dest.all.PoolSNP.001.50.26April2023.norep.ann.vcf.gz
  #
