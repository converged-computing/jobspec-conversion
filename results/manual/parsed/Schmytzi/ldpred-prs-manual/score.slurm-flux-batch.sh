#!/bin/bash
#FLUX: --job-name=crunchy-pastry-4691
#FLUX: --urgency=16

module load bioinfo-tools plink/1.90b4.9 
let "chr = $SLURM_ARRAY_TASK_ID % 22 + 1"
let "file = $SLURM_ARRAY_TASK_ID / 22"
all_weight_files=(weights/*)
weight_file=${all_weight_files[$file]}
weight_basename=$(basename $weight_file)
echo "Scoring chromosome $chr with weights from $weight_basename."
mkdir -p scores/$weight_basename
plink \
  --bed genotypes/chr${chr}.bed \
  --bim genotypes/chr${chr}.dedup.bim \
  --fam sample_info/samples.fam \
  --score $weight_file 3 5 7 header sum \
  --keep sample_info/validation.ids \
  --out scores/$weight_basename/scores_chr${chr}
