#!/bin/bash
#FLUX: --job-name=vcf
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module use /projects/apps/shared/modulefiles/;
module load python3 tskit SLiM/dev;
benscript="worms_mutations.slim"
path="/projects/phillipslab/ateterina/slim/worms_snakemake"
for dir in sim30rep sim70rep simmut15 balancing;do
cd $path/$dir
  listfiles=(d*C_15/*.full_out.txt)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  path=$(pwd)
  file2=${file/.full/}
  param=(${file2//_/ })
  POP_SIZE=$(awk '{print}' <<< "${param[3]}")
  MSCALE=$(awk '{print}' <<< "${param[7]}")
  DEL_FRAC=$(awk '{print}' <<< "${param[9]}")
  BEN_FRAC=$(awk '{print}' <<< "${param[11]}")
  DEL_MEAN_ARM=$(awk '{print}' <<< "${param[13]}")
  DEL_MEAN_CENT=$(awk '{print}' <<< "${param[15]}")
  BEN_MEAN_ARM=$(awk '{print}' <<< "${param[17]}")
  BEN_MEAN_CENT=$(awk '{print}' <<< "${param[19]}")
  slim -M  -d filename="'$file'" -d path="'$path'" -d POP_SIZE=$POP_SIZE -d MSCALE=$MSCALE -d DEL_FRAC=$DEL_FRAC -d BEN_FRAC=$BEN_FRAC -d DEL_MEAN_ARM=$DEL_MEAN_ARM -d DEL_MEAN_CENT=$DEL_MEAN_CENT -d BEN_MEAN_ARM=$BEN_MEAN_ARM -d BEN_MEAN_CENT=$BEN_MEAN_CENT  $path/$benscript
  sort -g -k2 -k1 ${file}.muts.O.S.txt > ${file}.muts.O.S.sort.txt
  sort -g -k2 -k1 ${file/.full_out.txt/.muts.txt} > ${file/.full_out.txt/.muts.sort.txt}
  paste -d'\t' ${file/.full_out.txt/.muts.sort.txt} ${file}.muts.O.S.sort.txt  > ${file/.full_out.txt/.ALLMUT.txt}
done
