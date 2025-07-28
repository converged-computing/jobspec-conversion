#!/bin/bash
#FLUX: --job-name=transcripts
#FLUX: --queue=componc_cpu,componc_gpu
#FLUX: -t=172800
#FLUX: --urgency=16

source /home/preskaa/miniconda3/bin/activate nf-core
module load singularity/3.7.1
outdir=/data1/shahs3/users/preskaa/bulk_illumina-rnaseq_test
samplesheet=${outdir}/test_samplesheet.csv
wrkdir=${outdir}/work
nextflow run shahcompbio/bulk-illumina-rnaseq \
  -c ${PWD}/conf/iris.config \
  -profile singularity,iris \
  -work-dir ${wrkdir} \
  -params-file nf-params.json \
  --input ${samplesheet} \
  --outdir ${outdir}
