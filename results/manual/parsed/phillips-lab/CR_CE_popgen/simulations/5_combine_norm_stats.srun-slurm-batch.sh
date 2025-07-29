#!/bin/bash
#FLUX: --job-name=combo
#FLUX: --queue=phillips
#FLUX: -t=126000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bedtools
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
norm="/projects/phillipslab/ateterina/slim/worms_snakemake/normalize_column.py"
for simdir in sim30rep sim70rep simmut15 neutral_extra balancing;do
  cd $dir/$simdir
  listfiles=(d*/*[015ypt].vcf)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  python3 $norm -i ${file/.vcf/.40kb.BETA} -o ${file/.vcf/.40kb.NORM.BETA}
  paste -d'\t' ${file/vcf/12stats_1mb_25_short.txt} ${file/.vcf/.40kb.NORM.BETA} >${file/.vcf/.1mb_25sw_fin.txt}
done
