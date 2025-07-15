#!/bin/bash
#FLUX: --job-name=_qqmanhattan
#FLUX: --queue=icelake-himem
#FLUX: -t=43200
#FLUX: --priority=16

export TMPDIR='${HPC_WORK}/work'
export caprion='~/Caprion/pilot'
export analysis='~/Caprion/analysis'
export suffix=''
export phenoname='$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/output/caprion${suffix}.varlist)'
export interval='${HPC_WORK}/data/interval'
export PERL5LIB=''

export TMPDIR=${HPC_WORK}/work
export caprion=~/Caprion/pilot
export analysis=~/Caprion/analysis
export suffix=
export phenoname=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/output/caprion${suffix}.varlist)
export interval=${HPC_WORK}/data/interval
. /etc/profile.d/modules.sh
module purge
export PERL5LIB=
module load rhel8/default-icl
module load samtools/1.13/gcc/zwxn7ug3
function rsid_snpid()
{
  seq 22 | \
  parallel -j1 -C' ' '
    echo {}
    export chr=chr${}
    export snpstats=~/rds/post_qc_data/interval/reference_files/genetic/reference_files_genotyped_imputed/impute_{}_interval.snpstats
    sed '1d' ${snpstats} | cut -f2-6 | awk "
    (\$4<\$5) {
      \$2=\$2+0; print \$2, \$3, \$1, \$2\":\"\$3\"_\"\$4\"_\"\$5
    }{
      \$2=\$2+0; print \$2, \$3, \$1, \$2\":\"\$3\"_\"\$5\"_\"\$4
    } " > ${analysis}/bgen/chr{}.rsid
  '
}
function bgen()
{
  export chr=chr${SLURM_ARRAY_TASK_ID}
  plink2 --bgen ${interval}/${chr}.bgen ref-unknown --sample ${interval}/interval.sample --keep ${analysis}/work/caprion${suffix}.id2 \
         --export bgen-1.2 bits=8 \
         --set-all-var-ids @:#_\$1_\$2 --new-id-max-allele-len 680 \
         --out ${analysis}/bgen/${chr}
  bgenix -g ${analysis}/bgen/${chr}.bgen -index -clobber
}
function freq()
{
  export chr=chr${SLURM_ARRAY_TASK_ID}
  plink2 --bgen ${analysis}/bgen/${chr}.bgen ref-unknown --sample ${analysis}/bgen/${chr}.sample \
         --freq \
         --out ${analysis}/bgen/${chr}-freq
  awk 'NR>1 && $5>=0.001 && $5<=0.999 {print $2}' ${analysis}/bgen/${chr}-freq.afreq > ${analysis}/bgen/${chr}.snplist
}
function freq.01()
{
  export chr=chr${SLURM_ARRAY_TASK_ID}
  plink2 --bgen ${analysis}/bgen/${chr}.bgen ref-unknown --sample ${analysis}/bgen/${chr}.sample \
         --freq \
         --out ${analysis}/bgen/${chr}-freq
  awk 'NR>1 && $5>=0.01 && $5<=0.99 {print $2}' ${analysis}/bgen/${chr}-freq.afreq > ${analysis}/bgen/${chr}-0.01.snplist
}
function fastLR()
{
  export phenocol=${SLURM_ARRAY_TASK_ID}
  export phenoname=$(awk 'NR==ENVIRON["phenocol"]{print $1}' ${analysis}/output/caprion${suffix}.varlist)
  export batch=${1}
  gcta-1.9 --mbgen ${analysis}/bgen/caprion.bgenlist \
           --sample ${analysis}/bgen/caprion.sample \
           --extract ${analysis}/bgen/caprion.snplist \
           --keep ${analysis}/output/caprion${suffix}-${batch}.id \
           --fastGWA-lr \
           --pheno ${analysis}/output/caprion${suffix}-${batch}.pheno --mpheno ${phenocol} \
           --threads 10 \
           --out ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}
  gcta-1.9 --mbgen ${analysis}/bgen/caprion.bgenlist \
           --sample ${analysis}/bgen/caprion.sample \
           --extract ${analysis}/bgen/caprion.snplist \
           --keep ${analysis}/output/chrX${suffix}-${batch}.id \
           --fastGWA-lr --model-only \
           --pheno ${analysis}/output/caprion${suffix}-${batch}.pheno --mpheno ${phenocol} \
           --threads 10 \
           --out ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}
  gcta-1.9 --bgen ${analysis}/bgen/chrX.bgen \
           --sample ${analysis}/bgen/chrX.sample \
           --extract ${analysis}/bgen/caprion.snplist --geno 0.1 \
           --keep ${analysis}/output/chrX${suffix}-${batch}.id \
           --load-model ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}.fastGWA \
           --threads 10 \
           --out ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}-chrX
  bgzip -f ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}.fastGWA
  bgzip -f ${analysis}/pgwas${suffix}/caprion${suffix}-${batch}-${phenoname}-chrX.fastGWA
}
function qqmanhattan()
{
  export phenoname=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/work/caprion${suffix}.varlist)${suffix}
  gunzip -c ${analysis}/METAL${suffix}/${phenoname}-1.tbl.gz | \
  awk '{if (NR==1) print "chromsome","position","log_pvalue","beta","se";
        else if ($1!=23) print $1,$2,-$12,$10,$11}' | \
  gzip -f > ${analysis}/work/${phenoname}.txt.gz
  R --slave --vanilla --args \
      input_data_path=${analysis}/work/${phenoname}.txt.gz \
      output_data_rootname=${analysis}/METAL${suffix}/qqmanhattanlz/${phenoname}_qq \
      plot_title="${phenoname}" < ~/cambridge-ceu/turboqq/turboqq.r
  if [ ! -f ${analysis}/METAL${suffix}/sentinels/${phenoname}.signals ]; then
     R --slave --vanilla --args \
       input_data_path=${analysis}/work/${phenoname}.txt.gz \
       output_data_rootname=${analysis}/METAL${suffix}/qqmanhattanlz/${phenoname}_manhattan \
       reference_file_path=~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda \
       pvalue_sign=5e-8 \
       plot_title="${phenoname}" < ~/cambridge-ceu/turboman/test.r
  else
    R --slave --vanilla --args \
      input_data_path=${analysis}/work/${phenoname}.txt.gz \
      output_data_rootname=${analysis}/METAL${suffix}/qqmanhattanlz/${phenoname}_manhattan \
      custom_peak_annotation_file_path=${analysis}/METAL${suffix}/vep/${phenoname}.txt \
      reference_file_path=~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda \
      pvalue_sign=5e-8 \
      plot_title="${phenoname}" < ~/cambridge-ceu/turboman/test.r
  fi
  rm ${analysis}/work/${phenoname}.txt.gz
}
function lz()
{
  module load python/2.7
  export phenoname=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/work/caprion${suffix}.varlist)${suffix}
  if [ -f ${analysis}/METAL${suffix}/sentinels/${phenoname}.signals ]; then
     (
       awk 'NR>1{print $6}' ${analysis}/METAL${suffix}/sentinels/${phenoname}.signals | \
       parallel -j1 -C' ' --env analysis --env phenoname '
         zgrep -w {} ${analysis}/METAL${suffix}/${phenoname}-1.tbl.gz | \
         awk -v rsid={} "{print \$1,\$2-5e5,\$2+5e5,rsid}"
       '
     ) | \
     parallel -j1 -C ' ' --env analysis --env phenoname '
     export type=$(awk "\$2==rsid {\$3=\$3 suffix; if(\$3==prot) print \$10}" FS="," rsid={4} prot=${phenoname} suffix=${suffix} \
                   ${analysis}/work/caprion${suffix}.cis.vs.trans)
     if [ {1} != "X" ]; then
       (
         echo -e "Chromosome\tPosition\tMarkerName\tlog10P"
         gunzip -c ${analysis}/METAL${suffix}/${phenoname}-1.tbl.gz | \
         awk -v chr={1} -v start={2} -v end={3} -v OFS="\t" "\$1==chr && \$2>=start && \$2<end {print \$1,\$2,\$3,-\$12}" | \
         sort -k1,1n -k2,2n
       ) > ${analysis}/work/${phenoname}-{4}.lz
       locuszoom --source 1000G_Nov2014 --build hg19 --pop EUR --metal ${analysis}/work/${phenoname}-{4}.lz \
                 --delim tab title="${phenoname}-{4} ($type)" \
                 --markercol MarkerName --pvalcol log10P --no-transform --chr {1} --start {2} --end {3} --cache None \
                 --no-date --plotonly --prefix=${phenoname} --rundir ${analysis}/METAL${suffix}/qqmanhattanlz --refsnp {4}
     else
       (
         echo -e "Chromosome\tPosition\tMarkerName\tlog10P"
         gunzip -c ${analysis}/METAL${suffix}/${phenoname}-1.tbl.gz | \
         awk -v chr={1} -v start={2} -v end={3} -v OFS="\t" "\$1==chr && \$2>=start && \$2<end {print \$1,\$2,\$3,-\$12}}" | \
         sort -k1,1n -k2,2n | \
         sed "s/_[A-Z]*_[A-Z]*//" | cut -f1-3,12 | sed "s/X/chr23/"
       ) > ${analysis}/work/${phenoname}-chrX-{4}.lz
       locuszoom --source 1000G_Nov2014 --build hg19 --pop EUR --metal ${analysis}/work/${phenoname}-chrX-{4}.lz \
                 --delim tab title="${phenoname}-chr{4} ($type)" \
                 --markercol MarkerName --pvalcol log10P --no-transform --chr {1} --start {2} --end {3} --cache None \
                 --no-date --plotonly --prefix=${phenoname}-chrX --rundir ${analysis}/METAL${suffix}/qqmanhattanlz \
                 --refsnp $(echo chr{4} | sed "s/_[A-Z]*_[A-Z]*//")
       rm ${analysis}/work/${phenoname}-{4}.lz
     fi
     '
  fi
}
function pairs()
{
  export caprion=~/Caprion
  export analysis=${caprion}/analysis
  export pgwas=${analysis}/pgwas
  export pilot=${caprion}/pilot
  export work=${analysis}/work
  export TMPDIR=${HPC_WORK}/work
  export uniprot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $2}' ~/Caprion/analysis/work/caprion.list)
  export protx=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ~/Caprion/analysis/work/caprion.list | sed 's/^\([0-9].*\)/X\1/g')
  export prot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ~/Caprion/analysis/work/caprion.list)
  gunzip -c ${pilot}/bgen/${uniprot}_invn-plink2.gz | cut -f1-3,6,9,10,12 | gzip -f > ${work}/${prot}-pilot-1.gz
  gunzip -c ${pilot}/bgen2/${protx}_All_invn-plink2.gz | cut -f1-3,6,9,10,12 | gzip -f > ${work}/${prot}-pilot-2.gz
  gunzip -c ${pilot}/bgen3/protein-${prot}_invn-plink2.gz | cut -f1-3,6,9,10,12 | gzip -f > ${work}/${prot}-pilot-3.gz
  seq 3 | parallel -C' ' 'gunzip -c ${pgwas}/caprion-{}-${prot}.fastGWA.gz | cut -f1-3,4,8-10 | gzip -f> ${work}/${prot}-{}.gz'
  Rscript -e '
    suppressMessages(library(dplyr))
    prot <- Sys.getenv("prot")
    work <- Sys.getenv("work")
    b1 <- read.delim(file.path(work,paste0(prot,"-pilot-1.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,b1=BETA,a1=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b2 <- read.delim(file.path(work,paste0(prot,"-pilot-2.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,b2=BETA,a2=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b3 <- read.delim(file.path(work,paste0(prot,"-pilot-3.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,b3=BETA,a3=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b <- b1 %>% left_join(b2) %>% left_join(b3) %>% mutate(b2=if_else(a1==a2,b2,-b2),b3=if_else(a1==a3,b3,-b3))
    cor(b[c("b1","b2","b3")],use="complete.obs",method="pearson")
    png(file.path("work",paste0(prot,"-pilot.png")),width=10,height=8,units="in",res=300)
    pairs(b[paste0("b",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
    b1 <- read.delim(file.path(work,paste0(prot,"-1.gz"))) %>% rename(b1=BETA,a1=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b2 <- read.delim(file.path(work,paste0(prot,"-2.gz"))) %>% rename(b2=BETA,a2=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b3 <- read.delim(file.path(work,paste0(prot,"-3.gz"))) %>% rename(b3=BETA,a3=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b <- b1 %>% left_join(b2) %>% left_join(b3) %>% mutate(b2=if_else(a1==a2,b2,-b2),b3=if_else(a1==a3,b3,-b3))
    cor(b[c("b1","b2","b3")],use="complete.obs",method="pearson")
    png(file.path("work",paste0(prot,".png")),width=10,height=8,units="in",res=300)
    pairs(b[paste0("b",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
    p1 <- read.delim(file.path(work,paste0(prot,"-pilot-1.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,p1=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p1=-log10(p1))
    p2 <- read.delim(file.path(work,paste0(prot,"-pilot-2.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,p2=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p2=-log10(p2))
    p3 <- read.delim(file.path(work,paste0(prot,"-pilot-3.gz"))) %>% rename(CHR=X.CHROM,SNP=ID,p3=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p3=-log10(p3))
    p <- p1 %>% left_join(p2) %>% left_join(p3)
    cor(p[c("p1","p2","p3")],use="complete.obs",method="pearson")
    png(file.path("work",paste0(prot,"-pilot-p.png")),width=10,height=8,units="in",res=300)
    pairs(p[paste0("p",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
    p1 <- read.delim(file.path(work,paste0(prot,"-1.gz"))) %>% rename(p1=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p1=-log10(p1))
    p2 <- read.delim(file.path(work,paste0(prot,"-2.gz"))) %>% rename(p2=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p2=-log10(p2))
    p3 <- read.delim(file.path(work,paste0(prot,"-3.gz"))) %>% rename(p3=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p3=-log10(p3))
    p <- p1 %>% left_join(p2) %>% left_join(p3)
    cor(p[c("p1","p2","p3")],use="complete.obs",method="pearson")
    png(file.path("work",paste0(prot,"-p.png")),width=10,height=8,units="in",res=300)
    pairs(p[paste0("p",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
  '
  rm ${work}/${prot}-pilot-?.gz ${work}/${prot}-?.gz
}
function pairs_p()
{
  export caprion=~/Caprion
  export analysis=${caprion}/analysis
  export pgwas=${analysis}/pgwas
  export pilot=${caprion}/pilot
  export work=${analysis}/work
  export TMPDIR=${HPC_WORK}/work
  export uniprot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $2}' ~/Caprion/analysis/work/caprion.list)
  export protx=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ~/Caprion/analysis/work/caprion.list | sed 's/^\([0-9].*\)/X\1/g')
  export prot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ~/Caprion/analysis/work/caprion.list)
  seq 3 | parallel -C' ' 'gunzip -c ${pgwas}/caprion-{}-${prot}.fastGWA.gz | awk "NR==1||\$10<=1e-5" | cut -f1-3,4,8-10 | gzip -f > ${work}/${prot}-{}.gz'
  Rscript -e '
    suppressMessages(library(dplyr))
    prot <- Sys.getenv("prot")
    work <- Sys.getenv("work")
    b1 <- read.delim(file.path(work,paste0(prot,"-1.gz"))) %>% rename(b1=BETA,a1=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b2 <- read.delim(file.path(work,paste0(prot,"-2.gz"))) %>% rename(b2=BETA,a2=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b3 <- read.delim(file.path(work,paste0(prot,"-3.gz"))) %>% rename(b3=BETA,a3=A1) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-SE,-P)
    b <- b1 %>% left_join(b2) %>% left_join(b3) %>% mutate(b2=if_else(a1==a2,b2,-b2),b3=if_else(a1==a3,b3,-b3))
    cor(b[c("b1","b2","b3")],use="complete.obs",method="pearson")
    png(file.path("~/Caprion/analysis/METAL/pairs",paste0(prot,".png")),width=10,height=8,units="in",res=300)
    pairs(b[paste0("b",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
    p1 <- read.delim(file.path(work,paste0(prot,"-1.gz"))) %>% rename(p1=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p1=-log10(p1))
    p2 <- read.delim(file.path(work,paste0(prot,"-2.gz"))) %>% rename(p2=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p2=-log10(p2))
    p3 <- read.delim(file.path(work,paste0(prot,"-3.gz"))) %>% rename(p3=P) %>%
          mutate(chrpos=paste0(CHR,":",POS)) %>% select(-CHR,-POS,-SNP,-BETA,-SE) %>% mutate(p3=-log10(p3))
    p <- p1 %>% left_join(p2) %>% left_join(p3)
    cor(p[c("p1","p2","p3")],use="complete.obs",method="pearson")
    png(file.path("~/Caprion/analysis/METAL/pairs",paste0(prot,"-p.png")),width=10,height=8,units="in",res=300)
    pairs(p[paste0("p",1:3)],cex=0.5,pch=19,upper.panel=NULL)
    dev.off()
  '
  rm ${work}/${prot}-?.gz
}
function miamiplot()
{
  export TMPDIR=/rds/user/jhz22/hpc-work/work
  export caprion=~/rds/projects/Caprion_proteomics/pilot
  export prot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${caprion}/2020.id | sed -r 's/^X([0-9])/\1/')
  export uniprot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $2}' ${caprion}/2020.id)
  (
    echo snpid chr pos rsid p z pr zr
    join \
    <(gunzip -c ~/Caprion/analysis/pgwas/caprion-1-${prot}.fastGWA.gz | \
      awk 'NR>1{if($4<$5) {a1=$4;a2=$5} else {a1=$5;a2=$4}; snpid=$1":"$2"_"a1"_"a2; print snpid,$1,$3,$2,$10,$8/$9}' | \
      sort -k1,1 \
     ) \
    <(gunzip -c ~/Caprion/analysis/pgwas/caprion-2-${prot}.fastGWA.gz  | \
      awk 'NR>1{if($4<$5) {a1=$4;a2=$5} else {a1=$5;a2=$4}; snpid=$1":"$2"_"a1"_"a2; print snpid,$10,$8/$9}' | \
      sort -k1,1 \
     )
  ) | gzip -f > ${analysis}/work/${uniprot}-${prot}-phase1-phase2.dat.gz
  module load gcc/6
  Rscript -e '
    analysis <- Sys.getenv("analysis")
    prot <- Sys.getenv("prot")
    uniprot <- Sys.getenv("uniprot")
    uniprot_prot <- read.table(file.path(analysis,"work",paste(uniprot,prot,"phase1-phase2.dat.gz",sep="-")),as.is=TRUE,header=TRUE)
    png(file.path(analysis,"METAL","miamiplot",paste(uniprot,prot,"phase1-phase2-fastGWA.png",sep="-")),res=300,width=12,height=10,units="in")
    gap::miamiplot(uniprot_prot,chr="chr",bp="pos",p="pr",pr="p",snp="rsid",cex=0.4,ylab="Phase II (top)/I (bottom)")
    z <- function(p) qnorm(p/2,lower.tail=FALSE)
    cor_z1_z2 <- with(uniprot_prot,cor(z,zr,use="complete.obs",method="pearson"))
    cor_p1_p2 <- with(uniprot_prot,cor(sign(z)*z(p),sign(zr)*z(pr),use="complete.obs",method="pearson"))
    sign_test_p1_p2 <- with(uniprot_prot,wilcox.test(p, pr, alternative="less", paired=TRUE, na.action="na.omit"))
    legend("topright",sprintf("Pearson r(z1,z2)=%.4f, r(z(p1),z(p2))=%.4f,Wilcoxon signed rank test p=%.4f",
           cor_z1_z2,cor_p1_p2,with(sign_test_p1_p2,p.value)))
    dev.off()
  '
  rm ${analysis}/work/${uniprot}-${prot}-phase1-phase2.dat.gz
}
function miamiplot2()
{
  export TMPDIR=/rds/user/jhz22/hpc-work/work
  export caprion=~/rds/projects/Caprion_proteomics/pilot
  export analysis=~/Caprion/analysis
  export prot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${caprion}/2020.id | sed -r 's/^X([0-9])/\1/')
  export uniprot=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $2}' ${caprion}/2020.id)
  module load gcc/6
  if [ ! -f ${analysis}/work/${uniprot}-${prot}-phase1.dat.gz ]; then
     (
       echo snpid chr pos rsid p z
       gunzip -c ~/Caprion/analysis/pgwas/caprion-1-${prot}.fastGWA.gz | \
       awk 'NR>1{if($4<$5) {a1=$4;a2=$5} else {a1=$5;a2=$4}; snpid=$1":"$3"_"a1"_"a2; print snpid,$1,$3,$2,$10,$8/$9}' | \
       sort -k2,2n -k3,3n
     ) | \
     gzip -f > ${analysis}/work/${uniprot}-${prot}-phase1.dat.gz
  fi
  if [ ! -f ${analysis}/work/${uniprot}-${prot}-phase2.dat.gz ]; then
     (
       echo snpid chr pos rsid p z
       gunzip -c ~/Caprion/analysis/pgwas/caprion-2-${prot}.fastGWA.gz  | \
       awk 'NR>1{if($4<$5) {a1=$4;a2=$5} else {a1=$5;a2=$4}; snpid=$1":"$3"_"a1"_"a2; print snpid,$1,$3,$2,$10,$8/$9}' | \
       sort -k2,2n -k3,3n
     ) | \
     gzip -f > ${analysis}/work/${uniprot}-${prot}-phase2.dat.gz
  fi
  Rscript -e '
  caprion <- Sys.getenv("caprion");analysis <- Sys.getenv("analysis"); prot <- Sys.getenv("prot"); uniprot <- Sys.getenv("uniprot")
  protein <- prot
  suppressMessages(require(dplyr))
  suppressMessages(require(gap))
  cvt <- read.csv("~/Caprion/analysis/work/caprion.cis.vs.trans")
  annot <- subset(cvt,prot==protein) %>%
           mutate(name=if_else(cis,paste(Gene,SNP,sep="-"),SNP))
  gwas1 <- read.table(file.path(analysis,"work",paste(uniprot,prot,"phase2.dat.gz",sep="-")),as.is=TRUE,header=TRUE) %>% filter(!is.na(p))
  gwas2 <- read.table(file.path(analysis,"work",paste(uniprot,prot,"phase1.dat.gz",sep="-")),as.is=TRUE,header=TRUE) %>% filter(!is.na(p))
  png(file.path(analysis,"METAL","miamiplot",paste(uniprot,prot,"phase1-phase2-fastGWA.png",sep="-")),res=300,width=12,height=10,units="in")
  chrmaxpos <- miamiplot2(gwas1,gwas2,name1="Batch 2",name2="Batch 1",z1="z",z2="z") %>%
               filter(chr!=-Inf & maxpos!=-Inf & genomestartpos!=-Inf & labpos!=-Inf)
  labelManhattan(chr=annot$SNPChrom,pos=annot$SNPPos,name=annot$name,gwas1,gwasZLab="z",chrmaxpos=chrmaxpos)
  dev.off()
  '
  rm ${analysis}/work/${uniprot}-${prot}-phase?.dat.gz
}
qqmanhattan
function fastGWA()
{
  gcta-1.9 --mbgen ${caprion}/bgen/caprion.bgenlist --grm-sparse ${caprion}/output/caprion-spgrm \
           --sample ${caprion}/bgen/caprion.sample \
           --fastGWA-mlm --pheno ${caprion}/output/caprion.pheno --mpheno ${SLURM_ARRAY_TASK_ID} --threads 10 \
           --out ${caprion}/work/caprion-${phenoname}
  gcta-1.9 --mbgen ${caprion}/bgen/caprion.bgenlist --grm-sparse ${caprion}/output/caprion-spgrm \
           --sample ${caprion}/bgen/caprion.sample \
           --fastGWA-mlm --model-only --pheno ${caprion}/output/caprion.pheno --mpheno ${SLURM_ARRAY_TASK_ID} \
           --keep ${caprion}/output/chrX.idlist --threads 10 \
           --out ${caprion}/work/caprion-${phenoname}
  gcta-1.9 --bgen ${caprion}/bgen/chrX.bgen \
           --sample ${caprion}/bgen/caprion.sample \
           --load-model ${caprion}/work/caprion-${phenoname}.fastGWA \
           --extract ${caprion}/output/chrX.snplist --geno 0.1 --threads 10 \
           --out ${caprion}/work/caprion-${phenoname}-chrX
  bgzip -f ${caprion}/work/caprion-${phenoname}*fastGWA
}
