#!/bin/bash
#FLUX: --job-name=goodbye-staircase-2191
#FLUX: -c=64
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

date;hostname;pwd
module load singularity
SINGULARITY_IMAGE="/blue/vendor-nvidia/hju/clara-parabricks-4.0.1-1"
DATA_DIR="/blue/vendor-nvidia/hju/data_parabricks/parabricks_sample"
SAMPLE_1="${DATA_DIR}/Data/sample_1.fq.gz"
SAMPLE_2="${DATA_DIR}/Data/sample_2.fq.gz"
REFERENCE="${DATA_DIR}/Ref/Homo_sapiens_assembly38.fasta"
IN_BAM="${DATA_DIR}/output.bam"
OUT_VARIANTS="${DATA_DIR}/deepvariant.vcf"
singularity exec \
    --nv \
    --bind ${DATA_DIR}:${DATA_DIR} \
    ${SINGULARITY_IMAGE} \
    pbrun deepvariant \
        --ref ${REFERENCE} \
        --in-bam ${IN_BAM} \
        --out-variants ${OUT_VARIANTS} \
        --num-gpus 4
