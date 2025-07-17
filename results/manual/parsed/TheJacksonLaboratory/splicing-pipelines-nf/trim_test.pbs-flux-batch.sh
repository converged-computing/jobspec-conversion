#!/bin/bash
#FLUX: --job-name=rainbow-muffin-6348
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=90000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
full_readLen=$(awk '$1=="readlength"{print $3}' NF_splicing_pipeline.config)
echo "read length"
echo ${full_readLen}
inc=${increment}
echo "increment"
echo ${inc}
readLen_1=$(( ${full_readLen} - $(( ${inc} * 1 )) ))
readLen_2=$(( ${full_readLen} - $(( ${inc} * 2 )) ))
readLen_3=$(( ${full_readLen} - $(( ${inc} * 3 )) ))
readLen_4=$(( ${full_readLen} - $(( ${inc} * 4 )) ))
readlengths="${readLen_1} ${readLen_2} ${readLen_3} ${readLen_4}"
echo "read lengths to test"
echo ${readlengths}
for readlength in $readlengths; do
   echo $readlength
   ./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
    --readlength $readlength \
    --star_index /projects/anczukow-lab/reference_genomes/human/Gencode/star_overhangs/star_${readlength} \
    --outdir results_${readlength} \
    --test \
    -config NF_splicing_pipeline.config \
    -profile base,sumner \
    --max_memory 200.GB --max_cpus 30 -resume
done
