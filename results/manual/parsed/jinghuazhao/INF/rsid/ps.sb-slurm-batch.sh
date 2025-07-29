#!/bin/bash
#FLUX: --job-name=_ps
#FLUX: --queue=cardio
#FLUX: -t=28800
#FLUX: --urgency=16

export nth='${SLURM_ARRAY_TASK_ID}'
export rsid='$(awk 'NR==ENVIRON["nth"]' ${INF}/ps/INF1_ref_rsid.txt)'

. /etc/profile.d/modules.sh
export nth=${SLURM_ARRAY_TASK_ID}
export rsid=$(awk 'NR==ENVIRON["nth"]' ${INF}/ps/INF1_ref_rsid.txt)
phenoscanner --snp=${rsid} --catalogue=GWAS --pvalue=5e-8 --proxies=EUR  --r2=0.8 --build=37 --wd=${INF}/ps/slurm --out ${rsid}
function summary()
{
  (
    cat ${INF}/ps/slurm/*SNP*tsv | head -1
    ls ${INF}/ps/slurm/*SNP*tsv | parallel -C' ' 'sed "1d" {}'
  ) > ${INF}/ps/SNP-single.tsv
  (
    cat ${INF}/ps/slurm/*GWAS*tsv | head -1
    ls ${INF}/ps/slurm/*GWAS*tsv | parallel -C' ' 'sed "1d" {}'
  ) > ${INF}/ps/GWAS-single.tsv
}
