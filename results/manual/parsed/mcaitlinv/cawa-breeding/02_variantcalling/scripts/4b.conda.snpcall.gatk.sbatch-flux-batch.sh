#!/bin/bash
#FLUX: --job-name=results/slurm_logs/variants/4b.gatk
#FLUX: --queue=shas
#FLUX: -t=86400
#FLUX: --priority=16

set -x
module purge
source ~/.bashrc
conda activate gatk4.2.5.0
cd $1
intervals=$(awk -v N=$SLURM_ARRAY_TASK_ID 'NR == N {print $1}' intervals2mb.list)
intervalID=$(echo "$intervals" | cut -f2 -d_ | cut -f1 -d.)
bamDir="/scratch/summit/caitlinv@colostate.edu/cawa-breed-wglc/results/bams"
reference="/projects/caitlinv@colostate.edu/genomes/cardellina_canadensis_pseudohap_v1.fasta"
mkdir -p results/variants/gatk
outname=$(printf 'results/variants/gatk/cawa2mb.interval.%s.vcf.gz'  $intervalID)
gatk --java-options "-Xmx30g -XX:+UseParallelGC -XX:ParallelGCThreads=8" HaplotypeCaller \
-R $reference \
$(printf ' -I %s ' $bamDir/*mergeMkDup.bam) \
-L $intervals \
-O ${outname}
