#!/bin/bash
#FLUX: --job-name=red-motorcycle-0138
#FLUX: -c=16
#FLUX: --urgency=16

source $HOME/alx-bio/scripts/_base.sh
conda_init conda
conda activate wf-human-var
THREADS=${SLURM_CPUS_PER_TASK:-8}
GPU=cuda:${SLURM_STEP_GPUS:-$SLURM_JOB_GPUS}
echo CPU: $THREADS\; GPU: $GPU
for i in /cluster/home/jiyuan/res/wf-human-var/images/*.tar; do
    echo "Loading $i"
    docker load -i $i
done
REF=$(get_ref hg38)
INPUT_FAST5_DIR=$1
OUT_DIR=${2:-.}
SAMPLE_ID=$3
nextflow run epi2me-labs/wf-human-variation \
    -w ${OUT_DIR}/wf-human-var \
    -offline \
    -profile standard \
    --methyl \
    --fast5_dir $INPUT_FAST5_DIR \
    --basecaller_basemod_threads $THREADS --cuda_device $GPU \
    --ref $REF \
    --basecaller_cfg 'dna_r9.4.1_e8_hac@v3.3'  \
    --remora_cfg 'dna_r9.4.1_e8_hac@v3.4_5mCG@v0' \
    --sample_name $2 \
    --out_dir ${OUT_DIR}/methyl
