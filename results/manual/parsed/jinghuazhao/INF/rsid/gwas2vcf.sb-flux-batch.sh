#!/bin/bash
#FLUX: --job-name=_gwas2vcf
#FLUX: --queue=cardio
#FLUX: -t=432000
#FLUX: --urgency=16

export TMPDIR='/rds/user/jhz22/hpc-work/work'
export prot='$(cut -f1 ${INF}/work/inf1.tmp | grep -v BDNF | sort | uniq | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')'

export TMPDIR=/rds/user/jhz22/hpc-work/work
if [ ! -f ${INF}/rsid/gwas2vcf.json ]; then
  R --no-save <<\ \ END
    library(jsonlite)
    j <- list(chr_col = 0, pos_col = 1, snp_col = 2, ea_col = 3, oa_col = 4, eaf_col = 5,
              beta_col = 6, se_col = 7, pval_col = 8, ncontrol_col = 9, delimiter = "\t",
              header = TRUE, build = "GRCh37")
    INF <- Sys.getenv("INF")
    write(toJSON(j, auto_unbox=TRUE, pretty=TRUE), file = file.path(INF,"rsid","gwas2vcf.json"))
  END
fi
export prot=$(cut -f1 ${INF}/work/inf1.tmp | grep -v BDNF | sort | uniq | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')
echo ${prot}
function metalLP()
{
  if [ ! -f ${INF}/METAL/gwas2vcf/LP/${prot}.txt.gz ]; then
     (
       awk -vOFS="\t" 'BEGIN{print "chr","pos","snpid","a1","a2","af","b","se","log10p","n"}'
       gunzip -c ${INF}/METAL/${prot}-1.tbl | \
       awk -vOFS="\t" 'NR>1{print $1,$2,$3,toupper($4),toupper($5),$6, $10, $11, $12, $18}' | \
       grep -v "<" | \
       sort -k1,1n -k2,2n
     ) | \
     bgzip -f > ${INF}/METAL/gwas2vcf/LP/${prot}.tsv.gz
     tabix -f -S1 -s1 -b2 -e2 ${prot}.tsv.gz
  fi
}
metalLP
function metalP()
{
  if [ ! -f ${INF}/METAL/gwas2vcf/${prot}.txt.gz ]; then
     (
       awk -vOFS="\t" 'BEGIN{print "chr","pos","snpid","a1","a2","af","b","se","p","n"}'
       gunzip -c ${INF}/METAL/${prot}-1.tbl | \
       awk -vOFS="\t" 'NR>1{print $1,$2,$3,toupper($4),toupper($5),$6, $10, $11, 10^($12), $18}' | \
       grep -v "<" | \
       sort -k1,1n -k2,2n
     ) | \
     bgzip -f > ${INF}/METAL/gwas2vcf/${prot}.tsv.gz
     tabix -f -S1 -s1 -b2 -e2 ${prot}.tsv.gz
  fi
}
function gwas2vcf()
{
  module load jdk-8u141-b15-gcc-5.4.0-p4aaopt
  module load gatk
  module load python/3.7
  cd ${HPC_WORK}/gwas2vcf
  source env/bin/activate
  if [ ! -f ${INF}/METAL/gwas2vcf/${prot}.vcf.gz ]; then
     python main.py --out ${INF}/METAL/gwas2vcf/${prot}.vcf.gz --data ${INF}/METAL/gwas2vcf/${prot}.tsv.gz \
                    --id ${prot} --ref human_g1k_v37.fasta --json ${INF}/rsid/gwas2vcf.json \
                    --dbsnp dbsnp.v153.b37.vcf.gz \
                    --alias alias.txt
     tabix -f ${INF}/METAL/gwas2vcf/${prot}.vcf.gz
  fi
  cd -
}
function vcfops()
{
  module load jdk-8u141-b15-gcc-5.4.0-p4aaopt
  module load gatk
  module load python/3.7
  module load picard/2.9.2
  export ensembl=${HPC_WORK}/gwas2vcf/ensembl
  export reference=${HPC_WORK}/gwas2vcf/human_g1k_v37
  export input=${INF}/METAL/vcf/${prot}
  export output=${INF}/work/${prot}-b38
  bcftools annotate -a ${ensembl}.bed.gz -c CHROM,FROM,TO,ENSG_ID \
                    -h <(echo '##INFO=<ID=ENSG_ID,Number=.,Type=String,Description="Ensembl gene ID">') \
                    -o ${output}.vcf.gz -O z -l ENSG_ID:unique ${input}.vcf.gz
  bcftools filter -r 1:1000000-2000000 -o ${input}-r.vcf.gz ${input}.vcf.gz
  bcftools filter -i 'FORMAT/LP > 7.3' -o ${input}-7.3.vcf ${input}.vcf.gz
  bcftools query -e 'ID == "."' -f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' ${input}.vcf.gz | \
  awk 'BEGIN {
  print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"
  }; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' | \
  gzip -f > ${input}.tsv.gz
  java -jar /usr/local/Cluster-Apps/picard/2.9.2/picard.jar CreateSequenceDictionary R=${reference}.fasta O=${reference}.dict
  gatk LiftoverVcf --INPUT ${input}.vcf.gz --OUTPUT ${output}.vcf.gz \
                   --REJECT ${input}-rejected.vcf.gz --CHAIN ${HPC_WORK}/bin/hg19ToHg38.over.chain \
                   --REFERENCE_SEQUENCE ${reference}.fasta --RECOVER_SWAPPED_REF_ALT false 
  gatk ValidateVariants -V ${output}.vcf.gz -R ${reference}.fasta --validation-type-to-exclude ALLELES
}
function gwasvcf()
{
module load gcc/6
R --no-save <<END
  options(width=200)
  library(gwasvcf)
  library(VariantAnnotation)
  library(gap)
  HPC_WORK <- Sys.getenv("HPC_WORK")
  set_bcftools(path=file.path(HPC_WORK,"bin","bcftools"))
  INF <- Sys.getenv("INF")
  prot <- Sys.getenv("prot")
  cat(prot,"\n")
  metal <- read.table(file.path(INF,"METAL",paste0(prot,"-1.tbl.gz")),as.is=TRUE,header=TRUE)
  out <- with(subset(metal,!grepl("<",Allele1)&grepl("<",Allele2)),
              create_vcf(chrom=Chromosome, pos=Position, nea=toupper(Allele2), ea=toupper(Allele1), snp=MarkerName,
                         ea_af=Freq1, effect=Effect, se=StdErr, pval=10^log.P., n=as.integer(N), name=prot)
             )
  vcf_name <- file.path(INF,"METAL","keep",paste0(prot,".vcf"))
  vcf_index <- paste0(vcf_name,".tbi")
  writeVcf(out, file=vcf,index=TRUE)
  create_rsidx_index_from_vcf(vcf_name, vcf_index)
END
}
