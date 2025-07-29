#!/bin/bash
#SBATCH --job-name=nf_rnafusion
#SBATCH --account=hpc_p_anderson
#SBATCH --output=%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=1-16:00:00
#SBATCH --constraint=skylake

module --force purge
module load StdEnv/2020
module load nextflow/22.10.6
module load gentoo/2020
module load singularity/3.9.2
DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/23-1ARMA/fusion_genes/hystiocystic_sarcoma
star_indice=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/23-1ARMA/fusion_genes/hystiocystic_sarcoma/analysis/indices                              
mkdir -p ${DIR}/analysis/nextflow
mkdir -p ${DIR}/analysis/nextflow/work
nextflow run nf-core/rnafusion \
                              -profile singularity \
                              --input ${DIR}/samplesheet.csv \
                              --outdir ${DIR}/analysis/nextflow \
                              -w ${DIR}/analysis/nextflow/work \
                              --build_references 'TRUE' \
                              --genome 'CanFam3.1' \
                              --starfusion_build 'TRUE' \
                              --star_fusion \
                              --fusion_inspector \
                              --max_memory '80.GB' \
                              --max_cpus 16 \
                              -resume
