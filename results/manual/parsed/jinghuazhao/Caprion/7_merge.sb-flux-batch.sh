#!/bin/bash
#FLUX: --job-name=_merge
#FLUX: --queue=icelake
#FLUX: -t=43200
#FLUX: --urgency=16

export TMPDIR='${HPC_WORK}/work'
export analysis='~/Caprion/analysis'
export suffix='_dr'
export p='$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/output/caprion${suffix}.varlist)${suffix}'

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load R/4.3.1-icelake
export TMPDIR=${HPC_WORK}/work
export analysis=~/Caprion/analysis
export suffix=_dr
export p=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${analysis}/output/caprion${suffix}.varlist)${suffix}
function setup()
{
  if [ ! -d ${analysis}/METAL${suffix}/sentinels/slurm ]; then mkdir -p ${analysis}/METAL${suffix}/sentinels/slurm; fi
}
function pgz()
{
  zcat ${analysis}/METAL${suffix}/${p}-1.tbl.gz | \
  awk 'NR>1 && $6>=0.01 && $6<=0.99 && $12<=log(5e-8)/log(10)' | \
  sort -k1,1n -k2,2n | \
  gzip -f > ${analysis}/METAL${suffix}/sentinels/${p}.p.gz
}
function _HLA()
{
  (
    zcat ${analysis}/METAL${suffix}/${p}-1.tbl.gz | awk -vOFS="\t" 'NR==1{$1="Chrom";$2="Start" "\t" "End";print}'
    zcat ${analysis}/METAL${suffix}/sentinels/${p}.p.gz | \
    awk -vOFS="\t" '{$1="chr" $1; start=$2-1;$2=start "\t" $2;print}' | \
    awk '!($1 == "chr6" && $3 >= 25392021 && $3 < 33392022)'
    zcat ${analysis}/METAL${suffix}/sentinels/${p}.p.gz | \
    awk -vOFS="\t" '{$1="chr" $1; start=$2-1;$2=start "\t" $2;print}' | \
    awk '$1 == "chr6" && $3 >= 25392021 && $3 < 33392022' | \
      sort -k13,13g | \
      awk 'NR==1'
  ) > ${analysis}/METAL${suffix}/sentinels/${p}_nold.p
  export lines=$(wc -l ${analysis}/METAL${suffix}/sentinels/${p}_nold.p | cut -d' ' -f1)
  if [ $lines -eq 1 ]; then
     echo removing ${p}_nold with $lines lines
     rm ${analysis}/METAL${suffix}/sentinels/${p}_nold.p
  fi
}
function sentinels()
{
  (
    mergeBed -i ${analysis}/METAL${suffix}/sentinels/${p}_nold.p -d 1000000 -c 13 -o min | \
    awk -v OFS="\t" -v trait=${p} '
    {
      if(NR==1) print "Chrom", "Start", "End", "P", "trait"
      print $0, trait
    }'
  ) > ${analysis}/METAL${suffix}/sentinels/${p}.merged
  (
    cut -f1-4,13 ${analysis}/METAL${suffix}/sentinels/${p}_nold.p| \
    bedtools intersect -a ${analysis}/METAL${suffix}/sentinels/${p}.merged -b - -wa -wb | \
    awk '$4==$10' | \
    cut -f1-5,9,10 | \
    awk -v OFS="\t" -v trait=${p} '
    {
      if(NR==1) print "Chrom", "Start", "End", "P", "trait", "MarkerName", "CHR", "POS", "SNP", "P_check"
      chr=gsub(/chr/,"",$1)
      print $1,$2,$3,$4,trait,$1":"$3,chr,$3,$6,$7
    }'
  ) | uniq > ${analysis}/METAL${suffix}/sentinels/${p}.sentinels
  Rscript -e '
    d <- file.path(Sys.getenv("analysis"),paste0("METAL",Sys.getenv("suffix")),"sentinels")
    prot <- Sys.getenv("p")
    f <- file.path(d,paste0(prot,".sentinels"))
    m <- read.table(f,header=TRUE,as.is=TRUE)
    dim(m)
    head(m)
    suppressMessages(library(dplyr))
    t <- m %>% group_by(trait,Chrom,Start,End) %>% slice(which.min(P))
    t
    P <- with(m,P)
    p <- table(P)[table(P)>1]
    print(p)
    m <- subset(t,MarkerName!=".")
    cols <- c(1:5,9)
    write.table(m[,cols],file=file.path(d,paste0(prot,".signals")),row.names=FALSE,quote=FALSE,sep="\t")
  '
}
for cmd in setup pgz _HLA sentinels; do $cmd; done
