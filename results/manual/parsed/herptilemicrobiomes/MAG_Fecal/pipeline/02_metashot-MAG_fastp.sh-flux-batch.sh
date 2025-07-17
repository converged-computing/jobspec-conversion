#!/bin/bash
#FLUX: --job-name=persnickety-pancake-4577
#FLUX: -n=32
#FLUX: --queue=batch
#FLUX: -t=259200
#FLUX: --urgency=16

export NXF_SINGULARITY_CACHEDIR='/bigdata/stajichlab/shared/singularity_cache/'

module load singularity
module load workspace/scratch
WORK=working
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
tail -n +2 $SAMPFILE | sed -n ${N}p | while read STRAIN SHOTGUN
do
  PREFIX=$STRAIN
  O=$WORK/$STRAIN/${STRAIN}_R{1,2}.fq.gz
  echo "O is $O"
  ./nextflow run metashot/mag-illumina \
	     --reads "$O" \
	     --outdir results/$STRAIN --max_cpus $CPU \
	     --scratch $SCRATCH -c metashot-MAG.cfg
done
