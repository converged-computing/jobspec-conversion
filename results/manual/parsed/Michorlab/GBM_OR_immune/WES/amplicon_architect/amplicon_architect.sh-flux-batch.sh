#!/bin/bash
#FLUX: --job-name=1_nextflow
#FLUX: -t=1209600
#FLUX: --priority=16

export CONDA_PREFIX='/aashn//miniconda3'
export CONDA_ROOT='/aashna/miniconda3'
export PATH='/aashna/miniconda3/bin:$PATH'
export NXF_SINGULARITY_CACHEDIR='/amplicon_architect/singularity'
export input='./amplicon_architect/sample_sheet.csv'
export output='/amplicon_architect/results/'
export cores='64'
export memory='256.GB'
export genome='GRCh38'
export time='14.day'
export filetype='BAM'
export data_repo='/amplicon_architect/data_repo/'
export mosek='/amplicon_architect/'
export AA_ref='GRCh38'
export pipeline='ampliconarchitect'
export image='/amplicon_architect/tools_latest.sif'

export CONDA_PREFIX=/aashn//miniconda3
export CONDA_ROOT=/aashna/miniconda3
export PATH=/aashna/miniconda3/bin:$PATH
source activate nextflow
module load singularity
export NXF_SINGULARITY_CACHEDIR=/amplicon_architect/singularity
export input=./amplicon_architect/sample_sheet.csv
export output=/amplicon_architect/results/
export cores=64
export memory=256.GB
export genome=GRCh38
export time=14.day
export filetype=BAM
export data_repo=/amplicon_architect/data_repo/
export mosek=/amplicon_architect/
export AA_ref=GRCh38
export pipeline=ampliconarchitect
export image=/amplicon_architect/tools_latest.sif
nextflow run /amplicon_architect/circdna --input $input --outdir $output --max_cpus $cores --max_memory $memory --max_time $time --genome $genome --input_format $filetype --bam_sorted true  --aa_data_repo $data_repo --mosek_license_dir $mosek --reference_build $AA_ref  -profile singularity --circle_identifier $pipeline $image
