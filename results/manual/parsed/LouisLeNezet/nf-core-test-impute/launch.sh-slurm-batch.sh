#!/bin/bash
#SBATCH --job-name=simul
#SBATCH --mail-user=louislenezet@gmail.com
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --constraint=avx2
#SBATCH --chdir=/groups/dog/llenezet/imputation/script/test_quality/wf_test

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
