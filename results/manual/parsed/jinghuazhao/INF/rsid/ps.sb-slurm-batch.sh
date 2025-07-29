#!/bin/bash
#SBATCH --job-name=_ps
#SBATCH --account=CARDIO-SL0-CPU
#SBATCH --output=/home/jhz22/INF/ps/slurm/_ps_%A_%a.out
#SBATCH --error=/home/jhz22/INF/ps/slurm/_ps_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12880
#SBATCH --time=08:00:00
#SBATCH --partition=cardio
#SBATCH --array=1-162

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
