#!/bin/bash
#FLUX: --job-name=count
#FLUX: -c=10
#FLUX: --priority=16

set -e ### stops bash script if line ends with error
echo ${HOSTNAME} ${SLURM_ARRAY_TASK_ID}
module purge
module load GCC/9.3.0 \
            SAMtools/1.10
featureCounts \
  -T 10 \
  -a ~/analyses/kendall/refs/annotations/danRer11.ensGene_WithERCC.gtf.gz \
  -o output/geneCounts/combined.txt \
  -p \
  --countReadPairs \
  -s 0 \
  output/aligned/*.bam
