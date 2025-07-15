#!/bin/bash
#FLUX: --job-name=hanky-train-1462
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONNOUSERSITE='1'
export SINGULARITY_BIND='/nesi/nobackup,/nesi/project'

module purge
module load Singularity
module load CUDA/11.4.1
export PYTHONNOUSERSITE=1
export SINGULARITY_BIND="/nesi/nobackup,/nesi/project"
REF=/refGenome/hg38/GRCh38_no_alt_plus_hs38d1_analysis_set/fasta/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna
OUTPUT_DIR=deepvariant_out
BAM=$1
SAMPLE=`basename ${BAM%.sorted.bam}`
mkdir -p ${OUTPUT_DIR}/${SAMPLE}
CONTAINER=/opt/nesi/containers/DeepVariant/deepvariant-1.5.0-gpu.simg
singularity run --nv $CONTAINER \
/opt/deepvariant/bin/run_deepvariant \
--model_type=WGS \
--ref=${REF} \
--reads=${BAM} \
--output_vcf=${OUTPUT_DIR}/${SAMPLE}/${SAMPLE}.vcf.gz \
--output_gvcf=${OUTPUT_DIR}/${SAMPLE}/${SAMPLE}.gvcf.gz \
--intermediate_results_dir=${OUTPUT_DIR}/${SAMPLE}/intermediate_results_dir \
--num_shards=${SLURM_CPUS_PER_TASK}
