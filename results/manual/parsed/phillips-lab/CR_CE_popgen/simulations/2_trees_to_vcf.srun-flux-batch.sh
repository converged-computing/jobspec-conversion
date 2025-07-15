#!/bin/bash
#FLUX: --job-name=vcf
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
tree2vcf="/projects/phillipslab/ateterina/slim/worms_snakemake/tree2vcf_mutrate.py" #uses worms.hapmap file, change the path
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
for simdir in sim30rep sim70rep simmut15 neutral_extra balancing decay decay_balancing exponent fluctuations;do
  cd $dir/$simdir
  listfiles=(d*/*trees)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  echo $file
  param=(${file//_/ })
  Ne=${param[3]}
  DIFF=${param[7]}
  FRAC=$(awk '{print $1+$2}' <<<"${param[9]} ${param[11]}")
  echo $DIFF
  echo $Ne
  echo $FRAC
  python3 $tree2vcf -t $file -v ${file/.trees/.vcf} -d $DIFF -f $FRAC -n $Ne -s 100
done
