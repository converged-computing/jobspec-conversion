#!/bin/bash
#FLUX: --job-name=_pwcoco
#FLUX: --queue=cardio
#FLUX: -t=43200
#FLUX: --urgency=16

function gwasglue()
{
cat << 'EOL' > ${INF}/coloc/gwasglue.sb
Rscript -e '
run_pwcoco <- function(id1,id2,region,
                       path_to_pwcoco="/usr/local/Cluster-Apps/ceuadmin/PWCoCo/1.0/build/pwcoco",
                       type1="quant",type2="cc",
                       workdir=Sys.getenv("HPC_WORK"))
{
  cat("id1=",id1,"id2=",id2,"\n")
  INF <- Sys.getenv("INF")
  attach(region)
  bfile <- file.path(INF,"INTERVAL","per_chr",paste0("interval.imputed.olink.chr_",chr))
  chrompos <- paste0(chr,":",start-M,"-",end+M)
  detach(region)
  suppressMessages(library(gwasglue))
  res <- pwcoco(id1,id2,bfile,chrompos,path_to_pwcoco,type1=type1,type2=type2,workdir=workdir)
  print(res)
}
{
  M <- 100000
  region <- list(chr=11,start=60869867,end=60895324,M=M)
  chrompos <- with(region,paste0(chr,":",start-M,"-",end+M))
  run_pwcoco("ebi-a-GCST90000452","ieu-a-1112",region)
  region <- list(chr=20,start=44746911,end=44758502,M=M)
  chrompos <- with(region,paste0(chr,":",start-M,"-",end+M))
  run_pwcoco("ebi-a-GCST90011997","ieu-b-18",region)
}
'
Rscript -e '
  suppressMessages(library(dplyr))
  INF <- Sys.getenv("INF")
  st14 <- read.delim(file.path(INF,"work","st14.tsv")) %>%
          select(Protein,ID,Disease) %>%
          left_join(pQTLdata::inf1[c("prot","target.short","chr","start","end")],by=c("Protein"="target.short"))
  write.table(st14,row.names=FALSE,quote=FALSE,sep="\t",col.names=FALSE)
' | \
parallel -C '\t' '
  export Protein={1}
  export ID={2}
  export Disease="{3}"
  export prot={4}
  export chr={5}
  export start={6}
  export end={7}
  export M=1000000
  Rscript -e "
    Protein <- Sys.getenv(\"Protein\")
    ID <- Sys.getenv(\"ID\")
    Disease <- Sys.getenv(\"Disease\")
    prot <- Sys.getenv(\"prot\")
    chr <- Sys.getenv(\"chr\")
    start <- as.integer(Sys.getenv(\"start\"))
    end <- as.integer(Sys.getenv(\"end\"))
    M <- as.integer(Sys.getenv(\"M\"))
    chrompos <- paste0(chr,\":\",start-M,\"-\",end+M)
    prot_vcf <- paste0(\"~/INF/METAL/gwas2vcf/\",prot,\".vcf.gz\")
    trait_vcf <- paste0(\"~/INF/OpenGWAS/\",ID,\".vcf.gz\")
    out_dir <- paste0(\"~/hpc-work/work/\",prot,\"-\",ID)
    cat(Protein,ID,Disease,prot,chr,start,end,\"\n\")
    gwasvcf::set_bcftools(path=\"/rds/user/jhz22/hpc-work/bin/bcftools\")
    gwasglue::gwasvcf_to_pwcoco(prot_vcf, trait_vcf, chrompos, type1 = \"quant\", type2 = \"cc\", out_dir)
  "
'
EOL
sed -i "s|DIR|${INF}/coloc|" ${INF}/coloc/gwasglue.sb
sbatch --wait ${INF}/coloc/gwasglue.sb
}
gwasglue
function init()
{
  export chr=12
  export pos=6514963
  export ichip=~/rds/results/public/gwas/multiple_sclerosis/ImmunoChip_Results/Immunochip_FinalResults_LimitedDiscovery.txt
  awk -vchr=${chr} -vpos=${pos} -vM=100000 'NR==1||($1==chr && $3>=pos-M && $3<pos+M){
      if(NR==1) print "SNP","A1","A2","b","se","p","N";
      if($5<$6) snpid="chr"$1":"$3"_"$5"_"$6;
      else snpid="chr"$1":"$3"_"$6"_"$5
      if(NR>1) print snpid,$5,$6,$7,log($10),$11,$9,10000
  }' ${ichip} > ${INF}/MS/ichip.ma
  export v3=~/rds/results/public/gwas/multiple_sclerosis/discovery_metav3.0.meta.gz
  gunzip -c ${v3} | \
  awk -vchr=${chr} -vpos=${pos} -vM=100000 'NR==1||($1==chr && $2>=pos-M && $2<pos+M){
      if(NR==1) print "SNP","A1","A2","P","OR";
      if($4<$5) snpid="chr"$1":"$2"_"$4"_"$5;
      else snpid="chr"$1":"$2"_"$5"_"$4
      if(NR>1) print snpid,$4,$5,$7,$8
  }' | \
  Rscript -e '
     v3 <- within(read.table("stdin",header=TRUE),{b=log(OR);se=b/qnorm(1-P/2);EAF=0.1;N=10000});
     INF <- Sys.getenv("INF")
     write.table(v3[c("SNP","A1","A2","EAF","b","se","P","N")],file=file.path(INF,"MS","v3.ma"),quote=FALSE,row.names=FALSE)
  '
  gunzip -c ${INF}/METAL/TNFB-1.tbl.gz | \
  awk -vchr=${chr} -vpos=${pos} -vM=100000 'NR==1||($1==chr && $2>=pos-M && $2<pos+M)' | \
  cut -f3-6,10-12,18 | \
  tr '\t' ' ' | \
  awk '{if(NR>1) {$2=toupper($2);$3=toupper($3);$7=10^$7}};1' > ${INF}/MS/LTA.ma
  module load ceuadmin/PWCoCo/1.0
  pwcoco --bfile ${INF}/INTERVAL/cardio/INTERVAL \
         --chr 12 \
         --sum_stats1 ${INF}/MS/ichip.ma \
         --sum_stats2 ${INF}/MS/LTA.ma \
         --p_cutoff1 1e-6 --p_cutoff2 5e-8 \
         --log ${INF}/MS/ichip-LTA-pwcoco \
         --out ${INF}/MS/ichip-LTA-pwcoco --out-cond
  pwcoco --bfile ${INF}/INTERVAL/cardio/INTERVAL \
         --chr 12 \
         --sum_stats1 ${INF}/MS/v3.ma \
         --sum_stats2 ${INF}/MS/LTA.ma \
         --p_cutoff1 1e-6 --p_cutoff2 5e-8 \
         --log ${INF}/MS/v3-LTA-pwcoco \
         --out ${INF}/MS/v3-LTA-pwcoco
}
function deprecated()
{
awk '{print $7,$8,$9,$10,$5,$6,$11,$12}' ${INF}/MS/TNFB-pQTL-rs2364485.dat > ${INF}/MS/LTA.ma
pwcoco --bfile ${INF}/INTERVAL/cardio/INTERVAL \
       --chr 12 \
       --sum_stats1 ${INF}/MS/EUR-ieu-a-1025.ma \
       --sum_stats2 ${INF}/MS/LTA.ma \
       --p_cutoff1 1e-6 --p_cutoff2 5e-8 \
       --log ieu-a-1025-LTA-pwcoco \
       --out ieu-a-1025-LTA-pwcoco
}
