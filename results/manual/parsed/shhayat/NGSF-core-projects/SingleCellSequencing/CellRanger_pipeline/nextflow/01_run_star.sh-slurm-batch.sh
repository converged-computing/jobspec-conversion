#!/bin/bash
#FLUX: --job-name=nf_singleCell
#FLUX: -c=40
#FLUX: -t=144000
#FLUX: --urgency=16

module --force purge
module load StdEnv/2020
module load nextflow/22.10.6
module load gentoo/2020
module load singularity/3.9.2
DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/SingleCellSequencing/CellRanger_pipeline/nextflow
REF=/datastore/NGSF001/analysis/references/cell_ranger_genome_builds/refdata-gex-mm10-2020-A/fasta/genome.fa
gtf=/datastore/NGSF001/analysis/references/cell_ranger_genome_builds/refdata-gex-mm10-2020-A/genes/genes.gtf
mkdir -p ${DIR}/analysis/results_star
nextflow run nf-core/scrnaseq -profile singularity \
                              --input ${DIR}/sample_info.csv \
                              --skip_fastqc 'TRUE' \
                              --aligner star \
                              --outdir ${DIR}/analysis/results_star \
                              --fasta ${REF} \
                              --gtf ${gtf}
