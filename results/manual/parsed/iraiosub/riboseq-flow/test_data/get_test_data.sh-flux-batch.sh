#!/bin/bash
#FLUX: --job-name=nf-fetch-ngs
#FLUX: --queue=cpu
#FLUX: -t=7200
#FLUX: --priority=16

export NXF_SINGULARITY_CACHEDIR='/nemo/lab/ulej/home/shared/singularity'
export NXF_HOME='/nemo/lab/ulej/home/users/luscomben/users/iosubi/.nextflow'

WORKDIR=/camp/lab/ulej/home/users/luscomben/users/iosubi/projects/ingolia_p1/data
module purge
ml Nextflow/23.04.2
ml Singularity/3.6.4
ml Graphviz/2.47.2-GCCcore-10.3.0
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/ulej/home/shared/singularity
export NXF_HOME=/nemo/lab/ulej/home/users/luscomben/users/iosubi/.nextflow
nextflow pull nf-core/fetchngs -r 1.10.1
nextflow run nf-core/fetchngs -r 1.10.1 \
   -profile singularity,crick \
   --input ids.csv \
   --outdir $WORKDIR/fastq
cd $WORKDIR/fastq/fastq
seqtk sample -s100 SRX19188681_SRR23242345.fastq.gz 30000 > subsampled_SRX19188681_SRR23242345.fastq
gzip subsampled_SRX19188681_SRR23242345.fastq
