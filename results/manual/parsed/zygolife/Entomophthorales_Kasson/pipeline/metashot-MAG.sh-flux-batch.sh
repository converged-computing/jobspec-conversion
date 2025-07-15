#!/bin/bash
#FLUX: --job-name=stinky-gato-3289
#FLUX: -t=691200
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
LIB=samples.csv
IFS=,
tail -n +2 $LIB | sed -n ${N}p | while read SAMPLE ILLSAMP SPECIES STRAIN PROJECT DESCRIPTION ASSEMBLYFOCUS
do
  R="$INPUT/${SAMPLE}_${ILLSAMP}_R[12]_001.fastq.gz"
  echo "O is $R, strain is $STRAIN"
  ./nextflow run metashot/mag-illumina \
	     --reads "$R" \
	     --outdir results/$STRAIN --max_cpus $CPU \
	     --scratch $SCRATCH -c metashot-MAG.cfg
done
