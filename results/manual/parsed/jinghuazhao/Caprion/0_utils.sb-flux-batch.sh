#!/bin/bash
#FLUX: --job-name=_utils
#FLUX: --queue=icelake-himem
#FLUX: -t=43200
#FLUX: --urgency=16

export PERL5LIB=''
export TMPDIR='${HPC_WORK}/work'
export analysis='~/Caprion/analysis'
export suffix='_dr'

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
export PERL5LIB=
module load ceuadmin/R/4.4.0-icelake
module load samtools/1.13/gcc/zwxn7ug3
module load perl/5.26.3_system/gcc-8.4.1-4cl2czq
module load libiconv/1.16/intel/64iicvbf
module load ceuadmin/ensembl-vep/111-icelake
export TMPDIR=${HPC_WORK}/work
export analysis=~/Caprion/analysis
export suffix=_dr
function duplicates()
{
  parallel -j8 -C' ' '
    echo chr{}
    bgenix -g ${analysis}/bgen/chr{}.bgen -list | \
    awk "NF==7" | \
    awk "a[\$2]++>0 {print \$2}" > ${analysis}/bgen/chr{}.dup
    bgenix -g ${analysis}/bgen/chr{}.bgen -list | \
    grep -f ${analysis}/bgen/chr{}.dup -w - > ${analysis}/bgen/chr{}.duplist
  ' ::: $(echo {1..22} X)
}
function pgwas()
{
  export protein=${1}
  export pqtl=${2}
  cd ~/Caprion/analysis/pgwas
  cat <(gunzip -c caprion${suffix}-?-${protein}.fastGWA.gz | head -1 | paste <(echo Batch-Protein) -|sed 's/-/\t/') \
      <(zgrep -w ${pqtl} caprion${suffix}-?-${protein}.fastGWA.gz) | \
  sed 's/caprion-//;s/.fastGWA.gz:/\t/;s/-/\t/' | \
 Rscript -e '
    suppressMessages(library(dplyr))
    pqtl <- Sys.getenv("pqtl")
    d <- read.table("stdin",header=TRUE) %>%
         arrange(Batch)
    knitr::kable(d,caption=paste("Effect sizes of",pqtl),digits=3)
  '
  cat <(gunzip -c ~/Caprion/analysis/METAL/${protein}-1.tbl.gz | head -1 | paste <(echo Protein) -) \
      <(zgrep -H -w ${pqtl} ~/Caprion/analysis/METAL/${protein}-1.tbl.gz) | \
  sed 's/INHBE//;s/-1.tbl.gz:/\t/;s/:/\t/' | \
  Rscript -e '
    suppressMessages(library(dplyr))
    pqtl <- Sys.getenv("pqtl")
    d <- read.table("stdin",header=TRUE) %>%
         arrange(Protein)
    knitr::kable(d,caption=paste("Effect sizes of",pqtl),digits=3)
  '
  cat <(gunzip -c ~/Caprion/analysis/METAL3/${protein}-1.tbl.gz | head -1 | paste <(echo Protein) -) \
      <(zgrep -H -w ${pqtl} ~/Caprion/analysis/METAL3/${protein}-1.tbl.gz) | \
  sed 's/INHBE//;s/-1.tbl.gz:/\t/;s/:/\t/' | \
  Rscript -e '
    suppressMessages(library(dplyr))
    pqtl <- Sys.getenv("pqtl")
    d <- read.table("stdin",header=TRUE) %>%
         arrange(Protein)
    knitr::kable(d,caption=paste("Effect sizes of",pqtl),digits=3)
  '
  cd ~/Caprion/analysis/peptide/${protein}/
  cat <(gunzip -c ${protein}-?-*.fastGWA.gz | head -1 | paste <(echo Batch-Peptide) -|sed 's/-/\t/') \
      <(zgrep -w ${pqtl} *fastGWA.gz) | \
  sed 's/INHBE-//;s/.fastGWA.gz:/\t/;s/-/\t/' | \
  Rscript -e '
    suppressMessages(library(dplyr))
    pqtl <- Sys.getenv("pqtl")
    d <- read.table("stdin",header=TRUE) %>%
         arrange(Peptide,Batch)
    knitr::kable(d,caption=paste("Effect sizes of",pqtl),digits=3)
  '
  cat <(gunzip -c METAL/*-1.tbl.gz | head -1 | paste <(echo Peptide) -) \
      <(zgrep -H -w ${pqtl} METAL/*-1.tbl.gz) | \
  sed 's|METAL/||;s/-1.tbl.gz:/\t/;s/:/\t/' | \
  Rscript -e '
    suppressMessages(library(dplyr))
    pqtl <- Sys.getenv("pqtl")
    d <- read.table("stdin",header=TRUE) %>%
         arrange(Peptide)
    knitr::kable(d,caption=paste("Effect sizes of",pqtl),digits=3)
  '
}
function fp_data()
{
  cp  ${analysis}/work/caprion${suffix}.merge ${analysis}/work/tbl${suffix}.tsv
  cut -f2-4 ${analysis}/work/tbl${suffix}.tsv | \
  awk 'NR>1' | \
  sort -k1,2n | \
  uniq | \
  awk -vOFS="\t" '{print $1":"$2,$3}' > ${analysis}/work/rsid${suffix}.tsv
  (
    gunzip -c ${analysis}/pgwas${suffix}/caprion${suffix}-*fastGWA.gz | head -1
    awk 'NR>1' ${analysis}/work/tbl${suffix}.tsv | \
    cut -f1,4,14 --output-delimiter=' ' | \
    parallel -j10 -C' ' '
      export direction=$(zgrep -w {2} ${analysis}/METAL${suffix}/{1}${suffix}-1.tbl.gz | cut -f13)
      let j=1
      for i in $(grep "Input File" ${analysis}/METAL${suffix}/{1}${suffix}-1.tbl.info | cut -d" " -f7)
      do
         export n=$(awk -vj=$j "BEGIN{split(ENVIRON[\"direction\"],a,\"\");print a[j]}")
         if [ "$n" != "?" ]; then zgrep -H -w {2} $i; fi
         let j=$j+1
      done
  '
  ) | \
  sed 's/.gz//g' > ${analysis}/work/all${suffix}.tsv
}
function fp()
{
  if [ ! -d ${analysis}/METAL${suffix}/fp ]; then mkdir -o mkdir -p ${analysis}/METAL${suffix}/fp; fi
  Rscript -e '
    require(gap)
    require(dplyr)
    analysis <- Sys.getenv("analysis")
    suffix <- Sys.getenv("suffix")
    cvt <- read.csv(file.path(analysis,"work",paste0("caprion",suffix,".cis.vs.trans"))) %>%
           select(prot,SNP,Type)
    tbl <- read.delim(file.path(analysis,"work",paste0("tbl",suffix,".tsv"))) %>%
           mutate(SNP=MarkerName,MarkerName=paste0(Chromosome,":",Position)) %>%
           left_join(cvt) %>%
           arrange(prot,SNP)
    all <- read.delim(file.path(analysis,"work",paste0("all",suffix,".tsv"))) %>%
           rename(EFFECT_ALLELE=A1,REFERENCE_ALLELE=A2) %>%
           mutate(CHR=gsub(suffix,"",CHR),
                  CHR=gsub("/home/jhz22/Caprion/analysis/pgwas/caprion-|.fastGWA","",CHR)) %>%
           mutate(batch_prot_chr=strsplit(CHR,"-|:"),
                  batch=unlist(lapply(batch_prot_chr,"[",1)),
                  prot=unlist(lapply(batch_prot_chr,"[",2)),
                  CHR=unlist(lapply(batch_prot_chr,"[",3)),CHR=gsub("chrX","23",CHR)) %>%
           mutate(MarkerName=paste0(CHR,":",POS),
                  study=case_when(batch == "1" ~ paste0("1. ZWK (",N,")"),
                                  batch == "2" ~ paste0("2. ZYQ (",N,")"),
                                  batch == "3" ~ paste0("3. UDP (",N,")"),
                                  TRUE ~ "---")) %>%
           arrange(study) %>%
           select(-batch_prot_chr)
    rsid <- read.table(file.path(analysis,"work",paste0("rsid",suffix,".tsv")),col.names=c("MarkerName","rsid"))
    pdf(file.path(analysis,"work",paste0("fp",suffix,".pdf")),width=8,height=5)
    METAL_forestplot(tbl,all,rsid,flag="Type",package="metafor",method="FE",cex=1.2,cex.axis=1.2,cex.lab=1.2,xlab="Effect")
    dev.off()
  '
}
function HetISq()
{
  Rscript -e '
    suppressMessages(require(dplyr))
    analysis <- Sys.getenv("analysis")
    suffix <- Sys.getenv("suffix")
    all <- read.delim(file.path(analysis,"work",paste0("all",suffix,".tsv"))) %>%
           mutate(CHR=gsub(suffix,"",CHR),CHR=gsub("/home/jhz22/Caprion/analysis/pgwas/caprion-|.fastGWA","",CHR)) %>%
           mutate(batch_prot_chr=strsplit(CHR,"-|:"),
                  batch=unlist(lapply(batch_prot_chr,"[",1)),
                  prot=unlist(lapply(batch_prot_chr,"[",2)),
                  CHR=unlist(lapply(batch_prot_chr,"[",3))) %>%
           mutate(MarkerName=paste0(CHR,":",POS),
                  Batch=case_when(batch == batch[1] ~ "1. ZWK",
                                  batch == batch[2] ~ "2. ZYQ",
                                  batch == batch[3] ~ "3. UDP",
                                  TRUE ~ "---"),
                  direction=case_when(sign(BETA) == -1 ~ "-", sign(BETA) == 1 ~ "+", sign(BETA) == 0 ~ "0", TRUE ~ "---")) %>%
           select(Batch,prot,-batch_prot_chr,MarkerName,SNP,A1,A2,N,AF1,BETA,SE,P,INFO,direction)
    b1 <- subset(all,Batch=="1. ZWK")
    names(b1) <- paste0(names(all),".ZWK")
    b1 <- rename(b1, prot=prot.ZWK, SNP=SNP.ZWK)
    b2 <- subset(all,Batch=="2. ZYQ")
    names(b2) <- paste0(names(all),".ZYQ")
    b3 <- subset(all,Batch=="3. UDP")
    names(b3) <- paste0(names(all),".UDP")
    b <- full_join(b1,b2,by=c('prot'='prot.ZYQ','SNP'='SNP.ZYQ')) %>%
         full_join(b3,by=c('prot'='prot.UDP','SNP'='SNP.UDP')) %>%
         mutate(directions=gsub("NA","?",paste0(direction.ZWK,direction.ZYQ,direction.UDP))) %>%
         select(-Batch.ZWK,-Batch.ZYQ,-Batch.UDP,direction.ZWK,direction.ZYQ,direction.UDP)
    tbl <- read.delim(file.path(analysis,"work",paste0("tbl",suffix,".tsv"))) %>%
           arrange(prot,MarkerName) %>%
           mutate(SNP=MarkerName,MarkerName=paste0(Chromosome,":",Position), index=1:n())
    Het <- filter(tbl,HetISq>=75) %>%
           select(prot,SNP,Direction,HetISq,index) %>%
           left_join(select(b,prot,SNP,P.ZWK,P.ZYQ,P.UDP,BETA.ZWK,BETA.ZYQ,BETA.UDP))
    write.csv(Het,file=file.path(analysis,"work", paste0("HetISq75",suffix,".csv")),row.names=FALSE,quote=FALSE)
    write(Het[['index']],file=file.path(analysis, "work", paste0("HetISq75",suffix,".index")),sep=",",ncolumns=nrow(Het))
  '
}
function ukb_ppp_lz()
{
  module load python/2.7
  export ukb_ppp=~/rds/results/public/proteomics/UKB-PPP/sun23
  export phenoname=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/work/caprion${suffix}.varlist)
  export flanking=500000
  if [ -f ${analysis}/METAL${suffix}/sentinels/${phenoname}${suffix}.signals ]; then
     awk '$3==prot{print $8,$9,$10,$2}' FS="," prot=${phenoname} ${analysis}/work/caprion${suffix}.cis.vs.trans | \
     parallel -j1 -C ' ' --env analysis --env phenoname '
     (
       echo -e "Chromosome\tPosition\tMarkerName\tlog10P"
       gunzip -c ${ukb_ppp}/European/${phenoname}_*bgz | \
       awk -v chr={1} -v pos={2} -v OFS="\t" "
       {
         split(\$3,a,\":\")
         if (\$1==chr && a[2]>=pos-5e5 && a[2]<pos+5e5) {print a[1],a[2],\"chr\"a[1]\":\"a[2],\$13}
       }" | \
       sort -k1,1n -k2,2n
     ) > ${analysis}/work/${phenoname}-{4}.lz
     locuszoom --source 1000G_Nov2014 --build hg19 --pop EUR --metal ${analysis}/work/${phenoname}-{4}.lz \
               --delim tab title="${phenoname}-{4} ({3})" \
               --markercol MarkerName --pvalcol log10P --no-transform --cache None \
               --chr {1} --start $(expr {2} - ${flanking}) --end $(expr {2} + ${flanking}) \
               --no-date --plotonly --prefix=${phenoname} --rundir ${analysis}/METAL${suffix}/ukb_ppp \
               --refsnp {4}
     if [ $(wc -l ${analysis}/work/${phenoname}-{4}.lz|cut -d" " -f1) -eq 1 ]; then rm ${analysis}/work/${phenoname}-{4}.lz; fi
     '
  fi
  # for f in $(ls *lz|sed 's/.lz//;s/-/_/'); do if [ ! -f $f.pdf ]; then echo $f; fi done
  # ANXA1_18:29037502_C_CTTTCTTTCTCTT CD59_X:9782142_A_T (HSPB1_rs114800762) LAMP2_X:119568477_G_C
  # export n2=$(expr $(ls *pdf | wc -l | cut -d' ' -f2) \* 2)
  # qpdf --empty --pages $(ls *pdf) -- UKB_PPP_LZ.pdf
  # qpdf --pages . 1-${n2}:odd -- UKB_PPP_LZ.pdf UKB_PPP-lz.pdf
}
function fplz()
{
  export metal=${analysis}/METAL${suffix}
  join -a1 <(sed '1d' ${analysis}/work/caprion${suffix}.merge | awk '{print $1"_"$4}' | sort -k1,1 ) \
           <(ls ${analysis}/METAL${suffix}/qqmanhattanlz/lz/*pdf | xargs -l basename -s .pdf | awk '{print $1,NR}') | \
  awk 'NF<2' | \
  sed 's/_/ /' | \
  parallel -C' ' 'ls ${analysis}/METAL${suffix}/qqmanhattanlz/lz/{1}*pdf'
  ulimit -n
  ulimit -S -n 2048
  qpdf --empty --pages $(sed '1d' ${analysis}/work/caprion${suffix}.merge | sort -k1,1 -k4,4 | cut -f1,4 --output-delimiter=' ' | \
                         parallel -C' ' 'ls $(echo ${analysis}/METAL${suffix}/qqmanhattanlz/lz/{1}_{2}.pdf | sed "s/:/_/")') -- lz2.pdf
  export npages=$(qpdf -show-npages lz2.pdf)
  qpdf --pages . 1-$npages:odd -- lz2.pdf lz.pdf
  pdfseparate lz.pdf temp-%04d-lz.pdf
  pdfseparate ${metal}/fp/fp.pdf temp-%04d-fp.pdf
  pdfjam temp-*-*.pdf --nup 2x1 --landscape --papersize '{7in,16in}' --outfile fp+lz.pdf
  rm temp*pdf
  qpdf fp+lz.pdf --pages . \
                 $(sed '1d' ${analysis}/work/caprion${suffix}.merge | sort -k1,1 -k4,4 | awk '$15>=75{printf " "NR}' | sed 's/ //;s/ /,/g') \
       -- HetISq75.pdf
}
function pdf()
{
  export f=${analysis}/work/caprion${suffix}.signals
  export N=$(sed '1d' ${f} | wc -l)
  export g=10
  export d=${analysis}/METAL${suffix}/qqmanhattanlz/
  module load ceuadmin/pdfjam gcc/6
  ls *_qq.png | xargs -l basename -s _qq.png | \
  parallel -C' ' 'convert -resize 150% {}_qq.png {}_qq.pdf;convert {}_manhattan.png {}_manhattan.pdf'
  qpdf --empty --pages $(ls *_qq.pdf) -- qq.pdf
  qpdf --empty --pages $(ls *_manhattan.pdf) -- manhattan.pdf
  pdfseparate qq.pdf temp-%04d-qq.pdf
  pdfseparate manhattan.pdf temp-%04d-manhattan.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR<=500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile qq-manhattan1.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>500 && NR<=1000') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile qq-manhattan2.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>1000 && NR<=1500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile qq-manhattan3.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>1500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile qq-manhattan4.pdf
  qpdf --empty --pages qq-manhattan*pdf -- qq-manhattan.pdf
  rm temp*
  sed '1d' ${f} | \
  awk -vN=${N} -vg=${g} '
  function ceil(v) {return(v+=v<0?0:0.999)}
  {
     gsub(":","_",$7)
     printf "%d %s %d %d %s\n", ceil(NR*g/N), $1, $2, $4, $7
  } ' > ${N}
  for i in `seq ${g}`
  do
     export n=$(awk -v i=${i} '$1==i' ${N} | wc -l)
     export n2=$(expr ${n} \* 2)
     qpdf --empty --pages $(awk -v i=${i} '$1==i' ${N} | \
                            awk -v d=${d} -v suffix=${suffix} '{print d"/lz/"$2 suffix"_"$5".pdf"}' | \
                            sort -k1,1 | \
                            tr '\n' ' ';echo) \
          -- lz2-${i}.pdf
     qpdf --pages . 1-${n2}:odd -- lz2-${i}.pdf lz-${i}.pdf
     rm lz2-${i}.pdf
  done
  qpdf --empty --pages $(echo lz-{1..10}.pdf) -- lz.pdf
  rm ${N}
  pdfseparate ${analysis}/work/fp.pdf temp-%04d-fp.pdf
  pdfseparate ${analysis}/METAL${suffix}/qqmanhattanlz/lz.pdf temp-%04d-lz.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR<=500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile fp-lz1.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>500 && NR<=1000') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile fp-lz2.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>1000 && NR<=1500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile fp-lz3.pdf
  pdfjam $(ls temp-*-*.pdf|awk 'NR>1500') --nup 2x1 --landscape --papersize '{5in,16in}' --outfile fp-lz4.pdf
  qpdf --empty --pages fp-lz*pdf -- fp-lz.pdf
  rm temp*
}
function mean_by_genotype_gen_sample()
{
  read prot chr bp pqtl < <(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]+1{gsub(/23/,"X",$2);print $1,$2,$3,$4}' ${analysis}/work/caprion${suffix}.merge)
  export prot=${prot}
  export chr=${chr}
  export bp=${bp}
  export pqtl=${pqtl}
  if [ "${chr}" != "X" ]; then
     export sample=${analysis}/work/caprion.sample
  else
     export sample=${analysis}/work/caprion-reduced.sample
  fi
  for batch in {1..3}
  do
    export batch=${batch}
    export out=${analysis}/pgwas${suffix}/means/caprion${suffix}-${batch}-${prot}-${pqtl}
    if [ ! -f ${out}.dat ]; then
       plink-2 --bgen ${analysis}/work/chr${chr}.bgen ref-unknown \
               --sample ${sample} \
               --chr ${chr} --from-bp ${bp} --to-bp ${bp} \
               --keep ${analysis}/work/caprion${suffix}-${batch}.id \
               --pheno ${analysis}/work/caprion${suffix}-${batch}.pheno --pheno-name ${prot} \
               --recode oxford \
               --out ${out}
       paste <(awk 'NR>2{print $1,$5}' ${out}.sample) \
             <(awk '{for(i=0;i<(NF-5)/3;i++) print $1,$2,$3,$4,$5, $(6+i),$(7+i),$(8+i)}' ${out}.gen) > ${out}.dat
       rm ${out}.gen ${out}.sample ${out}.log
    fi
  done
  Rscript -e '
     options(width=120)
     analysis <- Sys.getenv("analysis")
     suffix <- Sys.getenv("suffix")
     prot <- Sys.getenv("prot")
     pqtl <- Sys.getenv("pqtl")
     invisible(suppressMessages(sapply(c("dplyr","ggplot2","ggpubr"),require,character.only=TRUE)))
     process_batch <- function(batch,digits=3, genotypes=c("100","010","001"))
     {
       datfile <- file.path(analysis,paste0("pgwas",suffix),"means",paste(paste0("caprion",suffix),batch,prot,pqtl,sep="-"))
       dat <- read.table(paste0(datfile,".dat"),
                         colClasses=c("character","numeric","character","character","integer","character","character",rep("numeric",3)),
                         col.names=c("IID","Phenotype","chr","rsid","pos","A1","A2","g1","g2","g3")) %>%
              mutate(g=paste0(round(g1),round(g2),round(g3)),
                     Genotype=as.factor(case_when(g == genotypes[1] ~ paste0(A1,"/",A1),
                                                  g == genotypes[2] ~ paste0(A1,"/",A2),
                                                  g == genotypes[3] ~ paste0(A2,"/",A2),
                                                  TRUE ~ "---")))
       means <- group_by(dat,Genotype) %>%
                summarise(N=sum(!is.na(Phenotype)),Mean=signif(mean(Phenotype,na.rm=TRUE),digits))
       invisible(list(dat=dat,means=means))
     }
     v <- m <- list()
     for (batch in 1:3)
     {
         x <- process_batch(batch)
         v[[batch]] <- ggplot(with(x,dat), aes(x=Genotype, y=Phenotype, fill=Genotype)) +
                       geom_violin() +
                       geom_boxplot(width=0.1) +
                       theme_minimal()
         m[[batch]] <- ggtexttable(with(x,means), rows = NULL, theme = ttheme("mOrange"))
     }
     p <- ggarrange(v[[1]],v[[2]],v[[3]],m[[1]],m[[2]],m[[3]],ncol=3,nrow=2,labels=c("1. ZWK","2. ZYQ","3. UDP"))
     ggsave(file.path(analysis,paste0("pgwas",suffix),"means",paste0(prot,"-",pqtl,".png")),device="png",width=16, height=10, units="in")
  '
}
function mean_by_genotype_dosage()
{
  read prot chr bp pqtl < <(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]+1{gsub(/23/,"X",$2);print $1,$2,$3,$4}' ${analysis}/work/caprion${suffix}.merge)
  export prot=${prot}
  export chr=${chr}
  export bp=${bp}
  export pqtl=${pqtl}
  if [ "${chr}" != "X" ]; then
     export sample=${analysis}/work/caprion.sample
  else
     export sample=${analysis}/work/caprion-reduced.sample
  fi
  for batch in {1..3}
  do
    export batch=${batch}
    export out=${analysis}/pgwas${suffix}/means/caprion${suffix}-${batch}-${prot}-${pqtl}
    if [ ! -f ${out}.raw ]; then
       plink-2 --bgen ${analysis}/work/chr${chr}.bgen ref-unknown \
               --sample ${sample} \
               --chr ${chr} --from-bp ${bp} --to-bp ${bp} \
               --keep ${analysis}/work/caprion${suffix}-${batch}.id \
               --pheno ${analysis}/work/caprion${suffix}-${batch}.pheno --pheno-name ${prot} \
               --recode A include-alt \
               --out ${out}
       rm ${out}.log
       mv ${out}.raw ${out}.dosage
    fi
  done
  Rscript -e '
     options(width=120)
     analysis <- Sys.getenv("analysis")
     suffix <- Sys.getenv("suffix")
     prot <- Sys.getenv("prot")
     pqtl <- Sys.getenv("pqtl")
     invisible(suppressMessages(sapply(c("dplyr","ggplot2","ggpubr"),require,character.only=TRUE)))
     process_batch <- function(batch,digits=3)
     {
       datfile <- file.path(analysis,paste0("pgwas",suffix),"means",paste(paste0("caprion",suffix),batch,prot,pqtl,sep="-"))
       dat <- read.delim(paste0(datfile,".dosage"),check.names=FALSE,
                         colClasses=c("character","character","character","character","integer","numeric","numeric"))
       n7 <- names(dat)[7]
       names(dat)[6:7] <- c("Phenotype","Genotype")
       dat <- mutate(dat,Genotype=as.character(round(Genotype)))
       means <- group_by(dat,Genotype) %>%
                summarise(sum(!is.na(Phenotype)),Mean=signif(mean(Phenotype,na.rm=TRUE),digits))
       invisible(list(dat=dat,means=means,id=n7))
     }
     v <- m <- list()
     for (batch in 1:3)
     {
         x <- process_batch(batch)
         v[[batch]] <- ggplot(with(x,dat), aes(x=Genotype, y=Phenotype, fill=Genotype)) +
                       geom_violin() +
                       geom_boxplot(width=0.1) +
                       xlab(with(x,id)) +
                       theme_minimal()
         m[[batch]] <- ggtexttable(with(x,means), rows = NULL, theme = ttheme("mOrange"))
     }
     p <- ggarrange(v[[1]],v[[2]],v[[3]],m[[1]],m[[2]],m[[3]],ncol=3,nrow=2,labels=c("1. ZWK","2. ZYQ","3. UDP"))
     ggsave(file.path(analysis,paste0("pgwas",suffix),"means",paste0(prot,"-",pqtl,"-dosage.png")),device="png",width=16, height=10, units="in")
  '
}
function mean()
{
  awk '{gsub(/NA/,"0",$NF);print}' ${analysis}/work/caprion}.sample > ${analysis}/work/caprion${suffix}.sample
}
function INHBE
{
(
  pgwas INHBE rs149830883
  pgwas INHBE rs11172187
) > ~/Caprion/analysis/work/INHBE.txt
}
function hist_corr_lm()
{
Rscript -e '
  options(width=200)
  suppressMessages(library(Biobase))
  suppressMessages(library(dplyr))
  suppressMessages(library(Hmisc))
  suppressMessages(library(pheatmap))
  filter(pQTLdata::caprion,Protein=="INHBE_HUMAN") %>%
  select(Protein,Accession,Gene,Protein.Description)
  protein_peptide <- function(protein="INHBE",suffix="ZWK")
  {
    cat("\n**",suffix,"**\n",sep="")
    dir <- "~/rds/projects/Caprion_proteomics"
    load(file.path(dir,"pilot",paste(suffix,"rda",sep=".")))
    n <- paste("protein",suffix,sep="_")
    p <- exprs(get(n))
    g <- rownames(p) %in% paste(protein,"HUMAN",sep="_")
    prot <- matrix(p[g,],nrow=1,dimnames=list(protein,names(p[g,]))) %>%
            data.frame
    n <- paste("dr",suffix,sep="_")
    p <- exprs(get(n))
    g <- rownames(p) %in% paste(protein,"HUMAN",sep="_")
    dr <- matrix(p[g,],nrow=1,dimnames=list(protein,names(p[g,]))) %>%
          data.frame
    n <- paste("mapping",suffix,sep="_")
    m <- subset(get(n),grepl(protein,Protein))
    igID <- m[["Isotope.Group.ID"]]
    n <- paste("peptide",suffix,sep="_")
    p <- exprs(get(n))
    g <- rownames(p) %in% igID
    pept <- data.frame(p[g,])
    prot_pept <- bind_rows(pept,prot)
    n <- rownames(prot_pept)
    d <- t(prot_pept) %>%
         data.frame() %>%
         setNames(n)
    cat("\nProtein/Protein_DR")
    s1 <- summary(lm(INHBE~d[["442593377"]]+d[["442626845"]]+d[["442628596"]]+d[["442658425"]],data=d))
    dr_pept <- bind_rows(pept,dr)
    n <- rownames(dr_pept)
    d <- t(dr_pept) %>%
         data.frame() %>%
         setNames(n)
    s2 <- summary(lm(INHBE~d[["442593377"]]+d[["442626845"]]+d[["442628596"]]+d[["442658425"]],data=d))
    print(knitr::kable(cbind(coef(s1),coef(s2)),digits=3))
    opar <- par()
    png(file.path(dir,"analysis","work",paste(protein,suffix,"dist.png",sep="-")),
        width=12,height=10,units="in",pointsize=4,res=300)
    par(mar=c(15,10,5,5), font=2, font.lab = 5, font.axis = 5)
    source("https://raw.githubusercontent.com/jinghuazhao/tests/main/Hmisc/hist.data.frame.R")
    hist.data.frame(d,cex.axis=2.5,cex.lab=2.5,cex.mtext=2.5,cex.names=2.5,ylab=expression("Frequency"))
    dev.off()
    par(opar)
    png(file.path(dir,"analysis","work",paste(protein,suffix,"corr.png",sep="-")),
        width=12,height=10,units="in",pointsize=4,res=300)
    pheatmap(cor(t(prot_pept)),display_numbers=TRUE,fontsize=24)
    dev.off()
    write.csv(m[c("Isotope.Group.ID","Modified.Peptide.Sequence","Protein")],
              file=file.path(dir,"analysis","work",paste(protein,suffix,"mapping.csv",sep="-")),
              quote=FALSE,row.names=FALSE)
    prot_pept
  }
  zwk <- protein_peptide()
  zyq <- protein_peptide(suffix="ZYQ")
  udp <- protein_peptide(suffix="UDP")
'
}
function barplot()
{
Rscript -e '
  one <- read.delim("1")
  batches <- unique(with(one,Batch))
  peptides <- unique(with(one,Peptide))
  m <- s <- matrix(NA,length(peptides),length(batches))
  colnames(m) <- paste(batches)
  colnames(s) <- paste(batches)
  rownames(m) <- paste(peptides)
  rownames(s) <- paste(peptides)
  for(p in paste(peptides)) for(b in paste(batches))
  {
    d <- subset(one, Peptide==p & Batch==b)
    m[p,b] <- d[["BETA"]]
    s[p,b] <- d[["SE"]]
  }
  s.bar <- function(x, y, upper, lower=upper, length=0.1,...)
  {
    arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
  }
  png("INHBE-peptides.png",res=300,width=6,height=6,units="in")
  z <- barplot(m , beside=TRUE , legend.text=TRUE, args.legend=c(x=6,y=-0.9),
               col=c("blue" , "skyblue", "red", "green"), xlab="Batch", ylab="Beta", ylim=c(-1.2,0))
  s.bar(z,m,s)
  title("INHBE rs149830883 association")
  dev.off()
'
}
function ucsc_annotate()
{
  Rscript -e '
    options(width=200)
    library(dplyr)
    analysis <- Sys.getenv("analysis")
    suffix <- Sys.getenv("suffix")
    library(pQTLdata)
    nodup <- function(x) sapply(x, function(s) unique(unlist(strsplit(s,";")))[1])
    ucsc <- hg19Tables %>%
            group_by(acc) %>%
            summarize(
                 prot=paste(uniprotName,collapse=";"),
                 chrom=paste(X.chrom,collapse=";"),
                 start=min(chromStart),
                 end=max(chromEnd),
                 gene=paste(geneName,collapse=";")
            )
    # uniprot IDs are the same if proteins are the same
    p <- select(caprion,Accession,Protein,Gene) %>%
         left_join(ucsc,by=c("Protein"="prot")) %>%
         select(Accession,Protein,Gene,gene,acc,chrom,start,end)
    # however even with same uniprotID their protein names may be different
    u <- select(caprion,Accession,Protein,Gene) %>%
         left_join(ucsc,by=c("Accession"="acc")) %>%
         mutate(chrom=nodup(chrom)) %>%
         filter(!is.na(Protein)) %>%
         select(Accession,Protein,gene,Gene,prot,chrom,start,end)
    # The following check shows merge by uniprot is more sensible
    filter(p,Accession!=acc)
    filter(p,Gene!=gene)
    filter(p,is.na(start))
    filter(u,Protein!=prot)
    umiss <- with(u,is.na(start))
    filter(u,umiss) %>% pull(Accession)
    # "P04745" "P02655" "P55056" "P0C0L5" "P62805" "P69905"
    # confirmed form UniProt.org that Gene is more up-to-date
    # (obsolute), (APOC2), (APOC4), (C4B; C4B_2), (H4C1; H4C2; H4C3; H4C4; H4C5; H4C6; H4C8; H4C9; H4C11; H4C12; H4C13; H4C14; H4C15; H4C16), (HBA1; HBA2)
    # They are amended according to glist-hg19 in the function below.
    u[umiss,"Protein"] <- paste0(c("AMY1","APOC2","APOC4","CO4B","H4","HBA"),"_HUMAN")
    u[umiss,"Gene"] <- c("AMY1","APOC2","APOC4","CO4B","H4C","HBA")
    u[umiss,"chrom"] <- c("chr1","chr19","chr19","chr6","chr6","chr16")
    u[umiss,"start"] <- c(104198140,45449238,45445494,31949833,26021906,222845)
    u[umiss,"end"] <- c(104301311,45452822,45452822,32003195,27841289,227520)
    caprion_modified <- u
    a <- filter(u,umiss) %>%
         transmute(acc=Accession,prot=Protein,gene=Gene,chrom,start,end)
    ucsc2 <- ucsc %>%
             mutate(prot=nodup(prot),chrom=nodup(chrom),gene=nodup(gene)) %>%
             mutate(chrom=gsub("chrX","chr23",chrom),chrom=gsub("chrY","chr24",chrom))
             bind_rows(a)
    load("~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda")
    refgene_gene_coordinates_h19 <- ucsc2 %>%
                                    transmute(chromosome=gsub("chr","",chrom),
                                              gene_transcription_start=start,
                                              gene_transcription_stop=end,
                                              gene_name=gene,acc,prot,
                                              gene_transcription_midposition=(start+end)/2)
    save(ld_block_breaks_pickrell_hg19_eur,refgene_gene_coordinates_h19,file="ucsc_hg19_reference_data.rda")
    cis.vs.trans <- read.csv(file=file.path(analysis,"work",paste0("caprion",suffix,".cis.vs.trans"))) %>%
                    arrange(prot,SNPChrom,SNPPos,Type) %>%
                    transmute(prot,chrom=paste0("chr",SNPChrom),start=SNPPos,end=SNPPos,cistrans=Type)
    library(valr)
    d <- bed_intersect(cis.vs.trans,ucsc2) %>%
         transmute(chromosome=gsub("chr","",chrom),position=start.x,nearest_gene_name=gene.y,cistrans=cistrans.x,protein=prot.x)
    write.table(d,file="~/cambridge-ceu/turboman/caprion.txt",quote=FALSE,row.names=FALSE)
'
}
function vep_annotate()
{
  if [ ! -d ${analysis}/METAL${suffix}/vep/slurm ]; then mkdir -p ${analysis}/METAL${suffix}/vep/slurm; fi
  export cvt=${analysis}/work/caprion${suffix}.cis.vs.trans
  sed '1d' ${cvt} | \
  cut -d"," -f3 | \
  sort -k1,1 | \
  uniq | \
  parallel -C' ' '
    export protein={}
    (
      echo "##fileformat=VCFv4.0"
      echo "#CHROM" "POS" "ID" "REF" "ALT" "QUAL" "FILTER" "INFO"
      awk -vFS="," "\$3==ENVIRON[\"protein\"] {print \$2}" ${cvt} | \
      sort -k1,1 | \
      zgrep -f - -w ${analysis}/METAL${suffix}/{}${suffix}-1.tbl.gz | \
      cut -f1-5 | \
      awk "{gsub(/23/,\"X\",\$1);print \$1,\$2,\$3,toupper(\$4),toupper(\$5),\".\",\".\",\".\"}"
    ) | \
    tr " " "\t" > ${analysis}/METAL${suffix}/vep/{}.vcf
  # VEP annotation
    vep --input_file ${analysis}/METAL${suffix}/vep/{}.vcf \
        --output_file ${analysis}/METAL${suffix}/vep/{}.tab --force_overwrite \
        --cache --dir_cache /usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/.vep \
        --offline \
        --species homo_sapiens --assembly GRCh37 --pick --nearest symbol --symbol \
        --tab
    (
      echo chromosome position nearest_gene_name cistrans
      awk -vFS="," "\$3==ENVIRON[\"protein\"] {print \$2,\$8,\$9,\$10}" ${cvt} | \
      sort -k1,1 | \
      join - <(awk "!/#/{print \$1,\$21}" ${analysis}/METAL${suffix}/vep/{}.tab | sort -k1,1) | \
      awk "{print \$2,\$3,\$5,\$4}" | \
      sort -k1,1n -k2,2n | \
      uniq
    ) > ${analysis}/METAL${suffix}/vep/{}.txt
  '
}
function signal_comparison()
{
  Rscript -e '
    options(width=200)
    library(dplyr)
    cvt <- read.csv("~/Caprion/analysis/work/caprion.cis.vs.trans") %>%
           arrange(prot) %>%
           mutate(chrom=paste0("chr",SNPChrom),start=SNPPos,end=SNPPos)
    dim(cvt)
    head(cvt)
    cvt_dr <- read.csv("~/Caprion/analysis/work/caprion_dr.cis.vs.trans") %>%
              arrange(prot) %>%
              mutate(chrom=paste0("chr",SNPChrom),start=SNPPos,end=SNPPos)
    dim(cvt_dr)
    head(cvt_dr)
    library(valr)
    intersect(cvt,cvt_dr)
    right_join(cvt,cvt_dr,by=c("prot","SNP"))
    intersect(select(cvt,chrom,start,end),select(cvt_dr,chrom,start,end)) %>% nrow
  # 394
    intersect(select(cvt,chrom,start,end,prot,SNP),select(cvt_dr,chrom,start,end,prot,SNP)) %>% dim
  # 446
  # potential to add novelty check
  '
}
function ukb_ppp_a1bg()
{
  export rt=~/rds/results/public/proteomics/UKB-PPP/sun23
  export f=A1BG
  gunzip -c ${rt}/UKB-PPP\ pGWAS\ summary\ statistics\ \(reformatted\)/European\ \(discovery\)/A1BG_*gz | \
  awk 'NR==1||$13>=7.30103' > ${f}
  Rscript -e '
    options(width=200)
    library(dplyr)
    library(gap)
    library(valr)
    f <- Sys.getenv("f")
    tsv <- paste0(f,".tsv")
    d <- read.delim(tsv) %>%
         mutate(LOG10P=-LOG10P) %>%
         mutate(chrom=paste0("chr",CHROM),start=GENPOS,end=GENPOS)
    qtls <- qtlFinder(d,Chromosome="CHROM",Position="GENPOS",
                      MarkerName="ID",Allele1="ALLELE0",Allele2="ALLELE1",
                      EAF="A1FREQ",Effect="BETA",StdErr="SE",log10P="LOG10P",
                      build = "hg38") %>%
            mutate(rsid=gsub(":imp:v1","",rsid)) %>%
            select(-.overlap)
    geneSNP <- data.frame(gene="A1BG",rsid=pull(qtls,rsid),prot="A1BG")
    SNPPos <- data.frame(qtls) %>% select(rsid,chrom,start)
    genePos <- filter(pQTLdata::hg19,SYMBOL=="A1BG") %>% rename(chrom=chr) %>% bed_merge %>% cbind(gene="A1BG") %>% select(gene,chrom,start,end)
    cvt <- qtlClassifier(geneSNP,SNPPos,genePos,1e6)
    write.table(select(cvt,rsid,SNPChrom,SNPPos,Type),file=paste0(f,".cis.vs.trans"),quote=FALSE,row.names=FALSE)
    vcf <- paste0(f,".vcf")
    cat("##fileformat=VCFv4.0\n",file=vcf)
    cat("#CHROM POS ID REF ALT QUAL FILTER INFO\n",file=vcf,append=TRUE)
    cat(sprintf("%s %d %s %s %s %s %s %s\n",qtls[[1]],qtls[[2]],qtls[[4]],qtls[[5]],qtls[[6]],".",".","."),file=vcf,append=TRUE,sep="")
  '
  sed -i 's/ /\t/g' ${f}.vcf
  export cwd=${PWD}
  cd ${HPC_WORK}/loftee
  vep --input_file ${cwd}/${f}.vcf \
      --output_file ${cwd}/${f}.tab --force_overwrite \
      --cache --dir_cache ${HPC_WORK}/ensembl-vep/.vep --dir_plugins ${HPC_WORK}/loftee --offline \
      --species homo_sapiens --assembly GRCh37 --pick --nearest symbol --symbol --plugin TSSDistance \
      --plugin LoF,loftee_path:.,human_ancestor_fa:human_ancestor.fa.gz,conservation_file:phylocsf_gerp.sql.gz \
      --tab
  cd -
  (
      echo chromosome position nearest_gene_name cistrans
      sort -k1,1 ${f}.cis.vs.trans | \
      join - <(awk '!/#/{print $1,$21}' ${f}.tab | sort -k1,1) | \
      awk '{gsub("chr","",$2);print $2,$3,$5,$4}' | \
      sort -k1,1n -k2,2n
  ) > ${f}.txt
  export ukb_ppp="/rds/project/jmmh2/rds-jmmh2-results/public/proteomics/UKB-PPP/sun23"
  export bgz="${ukb_ppp}/European/A1BG_P04217_OID30771_v1_Inflammation_II.bgz"
  read -r chr start end < <(grep -w A1BG ${INF}/csd3/glist-hg19 | grep -v AS1 | cut -d' ' -f1-3)
  gunzip -c ${bgz} | \
  awk -vchr=${chr} -vstart=${start} -vend=${end} -vflanking=250000 -vOFS="\t" '{
        split($3,a,":")
        if (NR==1) print "chromsome","position","variant","ref_allele","alt_allele","alt_allele_freq","log_pvalue","beta","se";
        else if (a[1]==chr && a[2]>=start-flanking && a[2]<=end+flanking) print a[1],a[2],a[1]":"a[2]"_"a[3]"/"a[4],$4,$5,$6,$13,$10,$11
       }' | \
  bgzip -f > ${analysis}/work/${f}-ukb.tab.gz
  tabix -f -S1 -s1 -b2 -e2 ${analysis}/work/${f}-ukb.tab.gz
  Rscript -e '
    library(dplyr)
    library(jsonlite)
    analysis <- Sys.getenv("analysis")
    f <- Sys.getenv("f")
    merged_data <- list()
    d <- read.table(file.path(analysis,"work",paste0(f,"-ukb.tab.gz")),header=TRUE)
    json <- toJSON(list(data=d))
    sink(paste0(f,"-ukb.js"))
    cat("a1bg=")
    writeLines(json)
    sink()
  '
  awk '{
        split($3,a,":")
        if(a[1]=="X") a[1]=23
        if (NR==1) print "chromsome","position","log_pvalue","beta","se";
        else if (a[1]!=23) print a[1],a[2],$13,$10,$11
       }' | \
  gzip -f > ${f}.txt.gz
  gunzip -c ${bgz} | \
  R --slave --vanilla --args \
      input_data_path=${f}.txt.gz \
      output_data_rootname=${f}_qq \
      plot_title="${f}" < ~/cambridge-ceu/turboqq/turboqq.r
  if [ ! -f ${analysis}/METAL${suffix}/sentinels/${f}${suffix}.signals ]; then
     R --slave --vanilla --args \
       input_data_path=${f}.txt.gz \
       output_data_rootname=${f}_manhattan \
       reference_file_path=~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda \
       pvalue_sign=5e-8 \
       plot_title="${f}" < ~/cambridge-ceu/turboman/turboman.r
  else
    R --slave --vanilla --args \
      input_data_path=${f}.txt.gz \
      output_data_rootname=${f}_manhattan \
      custom_peak_annotation_file_path=${f}.txt \
      reference_file_path=~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda \
      pvalue_sign=5e-8 \
      plot_title="${f}" < ~/cambridge-ceu/turboman/turboman.r
  fi
  echo ${f} | parallel -C' ' 'convert -resize 150% {}_qq.png {}_qq.pdf;convert {}_manhattan.png {}_manhattan.pdf'
  module load ceuadmin/pdfjam
  pdfjam $(ls ${f}_qq.pdf ${f}_manhattan.pdf) --nup 2x1 --landscape --papersize '{7in,14in}' --outfile UKB-PPP-European-${f}-qq-manhattan.pdf
  Rscript -e '
   options(width=200)
   library(dplyr)
   library(pQTLdata)
   analysis <- Sys.getenv("analysis")
   d <- left_join(caprion[1:3],Olink_Explore_3072,by=c('Accession'='UniProt.ID')) %>%
        filter(!is.na(Protein.name))
   cvt <- read.csv(file.path(analysis,"work","caprion_dr.cis.vs.trans"),header=TRUE)
   dd <- left_join(cvt,d) %>%
         filter(!is.na(Protein.name)) %>%
         select(prot,SNP,geneChrom,geneStart,geneEnd,Protein,Accession)
  '
}
function maf()
{
  (
    awk -vFS="," 'NR>1{print $2,$3}' ${analysis}/work/caprion_dr.cis.vs.trans | \
    parallel -C' ' -j10 'zgrep -w {1} ${analysis}/METAL${suffix}/{2}${suffix}-1.tbl.gz | awk -vprot={2} "{print prot,\$3,\$6}"'
  ) | \
  sort -k1,1 -k2,2 > ${analysis}/work/caprion${suffix}.maf
}
function bgenX()
{
  (
    head -2 ~/Caprion/analysis/work/caprion.sample
    grep -f ~/Caprion/analysis/work/chrX.idlist  ~/Caprion/analysis/work/chrX.sample
  ) > ${analysis}/work/caprion-reduced.sample
  bgenix -g /home/jhz22/Caprion/analysis/work/chrX.bgen -list | \
  cut -f2 | \
  sed '1,2d' | \
  rev | \
  sed '1d' | \
  rev > ${analysis}/work/chrX.snpid
}
function lookup()
{
	Rscript -e '
	   options(width=200)
	   library(pQTLdata)
	   library(dplyr)
	   analysis <- Sys.getenv("analysis")
	   suffix <- Sys.getenv("suffix")
	   overlap_olink_1536 <- intersect(caprion[[2]],Olink_Explore_1536[[1]])
	   overlap_olink_ht <- intersect(caprion[[2]],Olink_Explore_HT[[1]])
	   signals <- read.csv(file.path(analysis,"work",paste0("caprion",suffix,".cis.vs.trans"))) %>%
	              select(-Gene) %>%
	              mutate(Protein=paste0(prot,"_HUMAN")) %>%
	              left_join(select(caprion,Protein,Accession,Gene),by="Protein") %>%
	              filter(Accession %in% overlap_olink_1536)
	'
}
function tojson()
{
  export flanking=250000
  export r=$(echo ${chr}:$(expr ${pos} - ${flanking})-$(expr ${pos} + ${flanking}))
  (
    echo chromosome position variant rsid ref_allele alt_allele alt_allele_freq log_pvalue beta se
    tabix ~/Caprion/analysis/METAL_dr/${prot}_dr-1.tbl.gz ${r} | \
    awk '{
          $5=toupper($5);$4=toupper($4)
          print $1,$2,$1":"$2"_"$5"/"$4,$3,$5,$4,$6,-$12,$10,$11
    }' | \
    sort -k1,1n -k2,2n
  ) | \
  tr ' ' '\t' | \
  bgzip -f > ${prot}-${rsid}.gz
  tabix -S1 -s1 -b2 -e2 ${prot}-${rsid}.gz
  Rscript -e '
    library(dplyr)
    library(jsonlite)
    prot <- Sys.getenv("prot")
    pqtl <- Sys.getenv("rsid")
    d <- read.delim(paste0(prot,"-",pqtl,".gz"))
    sink(paste0(prot,"-",pqtl,".json"))
    toJSON(list(data=d,analysis=paste0(prot,"-",pqtl)),auto_unbox=TRUE,pretty=FALSE)
    sink()
  '
}
export -f tojson
function lz_json()
{
  awk 'NR>1{print $1,$7}' ${analysis}/work/caprion${suffix}.signals | \
  parallel -C' ' '
    export prot={1}
    export rsid={2}
    export chrpos=$(grep -w ${rsid} ~/INF/work/INTERVAL.rsid | awk "{gsub(/chr|_[A-Z]*/,\"\",\$1);print \$1}")
    export chr=$(echo ${chrpos} | cut -d ":" -f1)
    export pos=$(echo ${chrpos} | cut -d ":" -f2)
    echo ${prot} ${rsid} ${chr} ${pos}
    tojson
  '
}
function json()
{
  Rscript -e '
    library(dplyr)
    library(jsonlite)
    suffix <- Sys.getenv("suffix")
    merged_data <- list()
    flist <- dir(pattern="json")
    for (i in 1:length(flist))
    {
      s <- unlist(strsplit(flist[i],"-|[.]"))
      f <- list(ppid=paste0(s[1],"-",s[2]),data=fromJSON(flist[i])$data[c("variant","position","ref_allele","alt_allele_freq","beta","log_pvalue")])
      merged_data <- c(merged_data,list(f))
    }
    merged_json <- toJSON(merged_data)
    sink(paste0("caprion",suffix,".js"))
    cat("input=")
    writeLines(merged_json)
    sink()
  '
}
function mbp()
{
Rscript -e '
mbp <- function(dir="work/",suffix="")
{
  rt <- "~/Caprion/analysis/"
  code <- c("ZWK","ZYQ","UDP")
  b <- data.frame()
  batch <- vector()
  for(i in 1:3)
  {
    if (dir=="output/" & suffix=="_dr")
    {
    pheno <- read.table(paste0(rt,dir,"caprion",suffix,"-",i,".pheno")) %>%
             select(-V1) %>%
             mutate(V2=paste0(code[i],V2)) %>%
             column_to_rownames(var="V2")
    } else
    {
    pheno <- read.delim(paste0(rt,dir,"caprion",suffix,"-",i,".pheno"),check.names=FALSE) %>%
             select(-FID) %>%
             mutate(IID=paste0(code[i],IID)) %>%
             column_to_rownames(var="IID")
    }
    b <- rbind(b,pheno)
    batch <- c(batch,rep(i,nrow(pheno)))
  }
  png(paste0(rt,dir,"caprion",suffix,".png"),height=8,width=20,units="in",res=300)
  quantro::matboxplot(t(b),batch,cex.axis=0.6,main="Box plots for phenotypes",
                      notch=TRUE,pch=19,ylab="Expression")
  dev.off()
}
require(dplyr)
require(tibble)
mbp()
mbp(suffix="_dr")
mbp(dir="output/")
mbp(dir="output/",suffix="_dr")
mbp(dir="scale/")
mbp(dir="scale/",suffix="_dr")
'
}
function umich()
{
  curl https://portaldev.sph.umich.edu/api/v1/statistic/single/ > single.json
  cat single.json | jq
  curl -G "https://portaldev.sph.umich.edu/api/v1/statistic/phewas/?build=GRCh37&format=objects" \
       --data-urlencode "filter=variant eq '10:114758349_C/T'" > t2d.json
  curl -G "https://portaldev.sph.umich.edu/api/v1/statistic/single/results/" \
       --data-urlencode "filter=analysis in 45 and chromosome in '10' and position ge 114258349 and position le 115258349" \
       --data-urlencode "fields=variant, position, log_pvalue"  --data-urlencode "sort=log_pvalue" > tcf7l2.json
  Rsript -e '
   options(width=200)
   library(jsonlite)
   single <- fromJSON("single.json")
   names(single)
   data.frame(single$data)[45,]
  '
}
function per_chr_snpid()
{
seq 22 | \
parallel -j10 -C' ' '
plink2 --bfile ~/INF/INTERVAL/per_chr/chr{} \
       --make-bed \
       --set-all-var-ids @:#_\$1_\$2 --new-id-max-allele-len 680 \
       --out ~/INF/INTERVAL/per_chr/snpid{}
'
plink2 \
       --allow-no-sex \
       --bgen ~/Caprion/analysis/bgen/chrX.bgen ref-unknown \
       --make-bed \
       --sample ~/Caprion/analysis/bgen/chrX.sample \
       --set-all-var-ids @:#_\$1_\$2 --new-id-max-allele-len 680 \
       --out ~/INF/INTERVAL/per_chr/snpidX
}
function tables()
{
R --no-save <<END
require(openxlsx)
suppressMessages(library(dplyr))
suppressMessages(library(gap))
require(stringr)
options(width=2000)
options("openxlsx.borderColour"="#4F80BD")
analysis <- Sys.getenv("analysis")
freq <- read.table("~/Caprion/analysis/bgen/caprion.freq",col.names=c("SNP","REF","ALT","ALT_FREQS"))
tbl <- read.delim(file.path(analysis,"work","tbl.tsv")) %>%
       select(prot,MarkerName,Allele1,Allele2,Freq1,Effect,StdErr,log.P.,Direction,HetISq,logHetP,N) %>%
       mutate(Allele1=toupper(Allele1),Allele2=toupper(Allele2)) %>%
       rename(Protein=prot,SNP=MarkerName,EA=Allele1,OA=Allele2,EAF=Freq1,Log10P=log.P.)
tbl_dr <- read.delim(file.path(analysis,"work","tbl_dr.tsv")) %>%
          select(prot,MarkerName,Allele1,Allele2,Freq1,Effect,StdErr,log.P.,Direction,HetISq,logHetP,N) %>%
          mutate(Allele1=toupper(Allele1),Allele2=toupper(Allele2)) %>%
          rename(Protein=prot,SNP=MarkerName,EA=Allele1,OA=Allele2,EAF=Freq1,Log10P=log.P.)
Protein <- read.csv(file.path(analysis,"work","caprion.cis.vs.trans")) %>%
           mutate(geneRegion=paste(geneChrom,":",geneStart,"-",geneEnd)) %>%
           left_join(freq) %>%
           arrange(prot,SNPChrom,SNPPos) %>%
           rename(Protein=prot) %>%
           select(-log10p,-geneChrom,-geneStart,-geneEnd,-SNPChrom,-SNPPos,-cis) %>%
           left_join(tbl) %>%
           select(Gene,Protein,geneRegion,SNP,Type,EA,OA,EAF,Effect,StdErr,Log10P,Direction,HetISq,logHetP,N,REF,ALT,ALT_FREQS)
Protein_dr <- read.csv(file.path(analysis,"work","caprion_dr.cis.vs.trans")) %>%
           mutate(geneRegion=paste(geneChrom,":",geneStart,"-",geneEnd)) %>%
           left_join(freq) %>%
           arrange(prot,SNPChrom,SNPPos) %>%
           rename(Protein=prot) %>%
           select(-log10p,-geneChrom,-geneStart,-geneEnd,-SNPChrom,-SNPPos,-cis) %>%
           left_join(tbl_dr) %>%
           select(Gene,Protein,geneRegion,SNP,Type,EA,OA,EAF,Effect,StdErr,Log10P,Direction,HetISq,logHetP,N,REF,ALT,ALT_FREQS)
proteins <- setdiff(dir("~/Caprion/analysis/peptide"),"15-01-2024") # c("A1BG","APOB","EPCR","ERAP2","PROC")
Peptides <- data.frame()
for (peptide in proteins)
{
   f <- file.path(analysis,"peptide",peptide,paste0(peptide,".cis.vs.trans"))
   if(file.exists(f))
   {
     p <- read.csv(f)
     if(nrow(p)>0) Peptides <- rbind(Peptides,p)
   }
}
repl <- with(Peptides,grepl("1433$",prot))
Peptides[repl,"prot"] <- "1433E"
Peptides <- left_join(Peptides,freq) %>%
            arrange(prot,isotope,SNPChrom,SNPPos) %>%
            rename(Protein=prot)
snplist_0.01 <- filter(freq,ALT_FREQS>=0.01 & ALT_FREQS<=0.99) %>%
                pull(SNP)
Protein_0.01 <- filter(Protein,SNP %in% snplist_0.01)
Protein_dr_0.01 <- filter(Protein_dr,SNP %in% snplist_0.01)
Peptides_0.01 <- filter(Peptides,SNP %in% snplist_0.01)
snplist_0.01_0.001 <- filter(freq,(ALT_FREQS>=0.001 & ALT_FREQS<0.01)|(ALT_FREQS>0.99 & ALT_FREQS<=0.999)) %>%
                      pull(SNP)
Protein_0.01_0.001 <- filter(Protein,SNP %in% snplist_0.01_0.001)
Protein_dr_0.01_0.001 <- filter(Protein_dr,SNP %in% snplist_0.01_0.001)
Peptides_0.01_0.001 <- filter(Peptides,SNP %in% snplist_0.01_0.001)
caprion <- dplyr::mutate(Protein, ProteinSNP=paste0(Protein,"-",SNP),inv_chr_pos_a1_a2(SNP),pos=as.integer(pos)) %>%
           dplyr::rename(prot=Protein,rsid=SNP,uniprot=Gene)
caprion_dr <- dplyr::mutate(Protein_dr, ProteinSNP=paste0(Protein,"-",SNP),inv_chr_pos_a1_a2(SNP),pos=as.integer(pos)) %>%
              dplyr::rename(prot=Protein,rsid=SNP,uniprot=Gene)
same <- intersect(caprion[["ProteinSNP"]],caprion_dr[["ProteinSNP"]])
cor(filter(caprion,ProteinSNP %in% same)["Effect"],
    filter(caprion_dr,ProteinSNP %in% same)["Effect"])
png(file.path(analysis,"work","caprion_caprion_dr.png"),height=8,width=8,units="in",res=300)
plot(filter(caprion,ProteinSNP %in% same)[["Effect"]],
     filter(caprion_dr,ProteinSNP %in% same)[["Effect"]],pch=19,
     main="Effect size comparison (N. pQTLs=559, r=0.999)",xlab="Beta",ylab="Beta_dr")
dev.off()
INF <- "/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/INF"
plink <- "/rds/user/jhz22/hpc-work/bin/plink"
b <- list()
for(i in unique(pull(caprion,chr)))
{
   k <- dplyr::filter(caprion,chr %in% i) %>%
        dplyr::select(chr,pos,uniprot,rsid,prot)
   dr <- dplyr::filter(caprion_dr,chr %in% i) %>%
         dplyr::select(chr,pos,uniprot,rsid,prot)
   bfile <- file.path(INF,"INTERVAL","per_chr",paste0("snpid",i))
   b[[i]] <- pQTLtools::novelty_check(k,dr,ldops=list(bfile,plink))
}
b[["23"]] <- mutate(b[["X"]],known.seqnames="23",query.seqnames="23")
replication <- dplyr::filter(bind_rows(b[-which(names(b)=="X")]),r2>=0.8) %>%
               dplyr::rename(known.gene=known.uniprot,query.gene=query.uniprot)
Replication <- dplyr::mutate(replication,seqnames=as.integer(known.seqnames),pos=as.integer(known.pos)) %>%
               dplyr::arrange(seqnames,pos) %>%
               dplyr::select(-known.start,-known.end,-query.seqnames,-query.start,-query.end,-seqnames,-pos)
hs <- createStyle(textDecoration="BOLD", fontColour="#FFFFFF", fontSize=12, fontName="Arial Narrow", fgFill="#4F80BD")
xlsx <- "https://jhz22.user.srcf.net/Caprion/results.xlsx"
xlsx <- file.path(analysis,"reports","results.xlsx")
wb <- createWorkbook(xlsx)
addWorksheet(wb,"Summary",zoom=150)
writeData(wb,"Summary","Summary",xy=c(1,1),headerStyle=createStyle(textDecoration="BOLD",
          fontColour="#FFFFFF", fontSize=14, fontName="Arial Narrow", fgFill="#4F80BD"))
summary <- data.frame(Sheet=c("Protein_0.01","Protein_dr_0.01","Peptides_0.01",
                              "Protein_0.01_0.001","Protein_dr_0.01_0.001","Peptides_0.01_0.001",
                              "Protein","Protein_dr","Peptides","Replication"),
                      Description=c("Unfiltered proteins, MAF>=0.01","DR-filtered proteins, MAF>=0.01","All peptides, MAF>=0.01",
                                    "Unfiltered proteins, MAF in (0.01,0.001]","DR-filtered proteins, MAF (0.01,0.001]",
                                    "All peptides, MAF in (0.01,0.001]",
                                    "Unfiltered proteins","DR-filtered proteins","All peptides","All/DR-filtered replication"))
writeDataTable(wb, "Summary", summary, xy=c(1,2), headerStyle=hs, firstColumn=TRUE, tableStyle="TableStyleMedium2")
for (i in c("Protein_0.01","Protein_dr_0.01","Peptides_0.01",
            "Protein_0.01_0.001","Protein_dr_0.01_0.001","Peptides_0.01_0.001",
            "Protein","Protein_dr","Peptides","Replication"))
{
    sheetnames <- i
    cat(sheetnames,"\n")
    addWorksheet(wb, sheetnames, zoom=150)
    writeData(wb, sheetnames, sheetnames, xy=c(1,1),
                  headerStyle=createStyle(textDecoration="BOLD",
                                          fontColour="#FFFFFF", fontSize=14, fontName="Arial Narrow", fgFill="#4F80BD"))
    body <- get(i)
    writeDataTable(wb, sheetnames, body, xy=c(1,2), headerStyle=hs, firstColumn=TRUE, tableStyle="TableStyleMedium2")
    freezePane(wb, sheetnames, firstCol=TRUE, firstActiveRow=3)
}
bStyle <- createStyle(fontColour = "#006100", bgFill = "#C6EFCE")
hStyle <- createStyle(fontColour = "#9C0006", bgFill = "#FFC7CE")
saveWorkbook(wb, file=xlsx, overwrite=TRUE)
END
}
  HetISq
