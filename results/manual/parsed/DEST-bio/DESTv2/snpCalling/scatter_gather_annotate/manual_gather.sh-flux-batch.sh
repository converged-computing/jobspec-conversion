#!/bin/bash
#FLUX: --job-name=manual_gather
#FLUX: --queue=standard
#FLUX: -t=50400
#FLUX: --urgency=16

module purge
module load htslib/1.10.2 bcftools/1.9 intel/18.0 intelmpi/18.0 parallel/20200322 vcftools/0.1.16
concatVCF() {
  popSet=all
  method=PoolSNP
  maf=001
  mac=50
  version=26April2023
  wd=/scratch/aob2x/DESTv2_output_26April2023
  chr=${1}
  echo "Chromosome: $chr"
  bcf_outdir="${wd}/sub_bcf"
  if [ ! -d $bcf_outdir ]; then
      mkdir $bcf_outdir
  fi
  outdir=$wd/sub_vcfs
  cd ${wd}
  echo "generate list"
  #ls -d *.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz | grep '^${chr}_' | sort -t"_" -k2n,2 -k4g,4 \
  #> $outdir/vcfs_order.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.sort
  ls -d ${outdir}/*.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz | \
  rev | cut -f1 -d '/' |rev | grep "^${chr}_"| sort -t"_" -k2n,2 -k4g,4 | \
  sed "s|^|$outdir|g" > $outdir/vcfs_order.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.sort
  echo "Concatenating"
  #bcftools concat \
  #-f $outdir/vcfs_order.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.sort \
  #-O z \
  #-n \
  #-o $bcf_outdir/dest.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz
  vcf-concat \
  -f $outdir/vcfs_order.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.sort \
  -s | \
  bgzip -c > $bcf_outdir/dest.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz
  tabix -p vcf $bcf_outdir/dest.${chr}.${popSet}.${method}.${maf}.${mac}.${version}.norep.vcf.gz
}
export -f concatVCF
parallel -j8 concatVCF ::: 2L 2R 3L 3R 4 mitochondrion X Y
