#!/bin/bash
#FLUX: --job-name=boopy-soup-3038
#FLUX: -n=32
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

export NXF_SINGULARITY_CACHEDIR='/bigdata/stajichlab/shared/singularity_cache/'

module load singularity
module load workspace/scratch
INPUT=input
SAMPFILE=samples.csv
export NXF_SINGULARITY_CACHEDIR=/bigdata/stajichlab/shared/singularity_cache/
CPU=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
  N=$1
fi
if [ -z $N ]; then
  echo "cannot run without a number provided either cmdline or --array in sbatch"
  exit
fi
IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read STRAIN FILEBASE
do
  PREFIX=$STRAIN
  O=""
  for BASEPATTERN in $(echo $FILEBASE | perl -p -e 's/\;/,/g');
  do
      if [ ! -z $O ]; 
      then
	  O="$O $INPUT/$BASEPATTERN"
      else
	  O="$INPUT/$BASEPATTERN"
      fi
  done
  echo "O is $O"
  ./nextflow run metashot/mag-illumina \
	     --reads "$O" \
	     --outdir results/$STRAIN --max_cpus $CPU \
	     --scratch $SCRATCH -c metashot-MAG.cfg
done
