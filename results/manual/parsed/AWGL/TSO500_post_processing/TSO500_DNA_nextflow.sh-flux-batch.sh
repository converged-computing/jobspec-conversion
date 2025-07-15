#!/bin/bash
#FLUX: --job-name=delicious-car-5175
#FLUX: --queue=high
#FLUX: --urgency=16

FASTQ_PATH=$1
SAMPLES_ORDER=$2
SEQID=$3
. ~/.bashrc
module load anaconda
set +u
conda activate somatic_enrichment_nextflow
set -u
nextflow -C /data/diagnostics/pipelines/somatic_enrichment_nextflow/somatic_enrichment_nextflow-main/config/somatic_enrichment_nextflow.config run /data/diagnostics/pipelines/somatic_enrichment_nextflow/somatic_enrichment_nextflow-main/somatic_enrichment_nextflow.nf \
    --fastqs ${FASTQ_PATH}/\*/\*\{R1.fastq.gz,R2.fastq.gz\} \
    --dna_list ${SAMPLES_ORDER} \
    --publish_dir results \
    --sequencing_run ${SEQID} \
    -with-dag ${SEQID}.png \
    -with-report ${SEQID}.html \
    -work-dir work \
    -resume &> pipeline.log
set +u
conda deactivate
set -u
if [[ `tail -n 1 results/post_processing_finished.txt` == "${SEQID} success!." ]]
then
    rm -r work/
fi
