#!/bin/bash
#SBATCH --job-name=test_nf_exon
#SBATCH --output=./test_nf_exon_%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --chdir=/scratch/mblab/edwardkang/exon_nf/

export SINGULARITY_CACHEDIR='/scratch/mblab/edwardkang/singularity/cache'

eval $(spack load --sh singularityce@3.8.0)
export SINGULARITY_CACHEDIR="/scratch/mblab/edwardkang/singularity/cache"
eval $(spack load --sh nextflow@22.10.4)
nextflow run exonPipeline_array.nf -c conf/sampleData_array.config
