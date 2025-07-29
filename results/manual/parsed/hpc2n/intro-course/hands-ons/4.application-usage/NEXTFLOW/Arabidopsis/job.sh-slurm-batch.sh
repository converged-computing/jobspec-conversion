#!/bin/bash
#SBATCH --account=hpc2n202Q-XYZ
#SBATCH --output=Chip_seq_analysis.out
#SBATCH --error=Chip_seq_analysis.err
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=1
#SBATCH --time=02:50:00

export NXF_OPTS='-Xms1g -Xmx4g'
export NXF_SINGULARITY_CACHEDIR='$PWD/sing-img'
export NXF_HOME='$PWD/home-nextflow'

ml Nextflow/22.10.1
ml FastQC/0.11.9-Java-11
export NXF_OPTS='-Xms1g -Xmx4g'
export NXF_SINGULARITY_CACHEDIR=$PWD/sing-img
export NXF_HOME=$PWD/home-nextflow
nextflow run nf-core/rnaseq \
    -profile singularity \
    --input design_test.csv \
    --genome 'TAIR10' \
    --max_cpus '14' \
    --max_memory '60GB' \
    --outdir $PWD \
    -resume
