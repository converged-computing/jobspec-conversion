#!/bin/bash
#FLUX: --job-name=rnaseq_human
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow
nextflow ../main.nf \
--workflow rnaseq \
-profile sumner \
--sample_folder <PATH_TO_YOUR_SEQUENCES> \
--gen_org human \
--pubdir '/fastscratch/outputDir' \
-w '/fastscratch/outputDir/work' \
--comment "This script will run rnaseq on human samples using default hg38"
