#!/bin/bash
#FLUX: --job-name=tabix
#FLUX: --queue=cardio
#FLUX: -t=43200
#FLUX: --priority=16

export TMPDIR='${HPC_WORK}/work'
export f='$(ls ~/rds/rds-jmmh2-results/public/gwas/blood_cell_traits/chen_2020/*EUR* | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')'
export d='$(dirname $f)'
export trait='$(basename $f | tr '_' '\t' | cut -f1)'

export TMPDIR=${HPC_WORK}/work
export f=$(ls ~/rds/rds-jmmh2-results/public/gwas/blood_cell_traits/chen_2020/*EUR* | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')
export d=$(dirname $f)
export trait=$(basename $f | tr '_' '\t' | cut -f1)
(
  gunzip -c $f | head -1 | awk -vFS="\t" -vOFS="\t" '{print "snpid",$0}'
  gunzip -c $f | sed '1d' | sort -k1,1n -k2,2n | \
  awk -vFS="\t" -vOFS="\t" '{if($3<$4) snpid="chr"$1":"$2"_"$3"_"$4; else snpid="chr"$1":"$2"_"$3"_"$4; print snpid,$0}'
) | \
bgzip -f > $d/tsv/EUR-$trait.tsv.gz
tabix -S1 -s2 -b3 -e3 $d/tsv/EUR-$trait.tsv.gz
