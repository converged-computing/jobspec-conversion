#!/bin/bash
#FLUX: --job-name=simul
#FLUX: -c=8
#FLUX: --priority=16

source /local/miniconda3/etc/profile.d/conda.sh
conda activate env_nf
nextflow \
    run main.nf \
    -c nextflow.config \
    --input /groups/dog/llenezet/imputation/script/test_quality/wf_test/assets/samplesheet.csv \
    --region /groups/dog/llenezet/imputation/script/test_quality/wf_test/assets/regionsheet.csv \
    --depth /groups/dog/llenezet/imputation/script/test_quality/wf_test/assets/depthsheet.csv \
    --panel /groups/dog/llenezet/imputation/script/test_quality/wf_test/assets/panelsheet.csv \
    --outdir /scratch/llenezet/nf/data/simulation \
    -work-dir /scratch/llenezet/nf/work \
    --max-cpus 8 \
    --max-memory '50.GB' \
    -profile singularity \
    -resume
