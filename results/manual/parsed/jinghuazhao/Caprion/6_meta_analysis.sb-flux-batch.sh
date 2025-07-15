#!/bin/bash
#FLUX: --job-name=_METAL
#FLUX: --queue=icelake-himem
#FLUX: -t=43200
#FLUX: --priority=16

export TMPDIR='${HPC_WORK}/work'
export caprion='~/Caprion'
export suffix='_dr'
export phenoname='$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${caprion}/analysis/output/caprion${suffix}.varlist)${suffix}'
export rt='${caprion}/analysis/METAL${suffix}'

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load samtools/1.13/gcc/zwxn7ug3
export TMPDIR=${HPC_WORK}/work
export caprion=~/Caprion
export suffix=_dr
export phenoname=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]{print $1}' ${caprion}/analysis/output/caprion${suffix}.varlist)${suffix}
export rt=${caprion}/analysis/METAL${suffix}
function METAL_analysis_old()
{
  metal ${rt}/${phenoname}.metal 2>&1 | tee ${rt}/${phenoname}-1.tbl.log
  bgzip -f ${rt}/${phenoname}-1.tbl
  metal ${rt}/${phenoname}-chrX.metal 2>&1 | tee ${rt}/${phenoname}-chrX-1.tbl.log
  bgzip -f ${rt}/${phenoname}-chrX-1.tbl
}
function METAL_analysis()
{
  metal ${rt}/${phenoname}.metal 2>&1 | tee ${rt}/${phenoname}-1.tbl.log
  cat <(head -1 ${st}/${phenoname}-1.tbl) <(sed '1d' ${rt}/${phenoname}-1.tbl | sort -k1,1n -k2,2n) | \
  bgzip -f > ${rt}/${phenoname}-1.tbl.gz
  tabix -S1 -s1 -b2 -e2 -f ${rt}/${phenoname}-1.tbl.gz
  rm ${rt}/${phenoname}-1.tbl
}
METAL_analysis
