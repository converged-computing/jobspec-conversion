#!/bin/bash
#FLUX: --job-name=run
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

export PATH='/n/groups/zhanglab/meng/tools/java/bin:/n/groups/zhanglab/meng/tools/samtools:/n/groups/zhanglab/meng/tools/bowtie2:/n/groups/zhanglab/meng/tools/fastqc:/n/groups/zhanglab/meng/tools/ucscTools:$PATH'
export LD_LIBRARY_PATH='/n/groups/zhanglab/meng/tools/java/lib:$LD_LIBRARY_PATH'

module load gcc/6.2.0
module load python/3.7.4
module load perl/5.30.0
module load R/3.6.1
export PATH=/n/groups/zhanglab/meng/tools/java/bin:/n/groups/zhanglab/meng/tools/samtools:/n/groups/zhanglab/meng/tools/bowtie2:/n/groups/zhanglab/meng/tools/fastqc:/n/groups/zhanglab/meng/tools/ucscTools:$PATH
export LD_LIBRARY_PATH=/n/groups/zhanglab/meng/tools/java/lib:$LD_LIBRARY_PATH
snakemake -j 8 -p
