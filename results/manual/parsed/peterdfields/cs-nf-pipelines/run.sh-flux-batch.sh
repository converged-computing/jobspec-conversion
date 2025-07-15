#!/bin/bash
#FLUX: --job-name=CS_nextflow_example
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow
nextflow main.nf \
-profile sumner \
--workflow rnaseq \
--gen_org mouse \
--sample_folder 'test/rna/mouse' \
--pubdir '/fastscratch/outputDir' \
-w '/fastscratch/outputDir/work'
