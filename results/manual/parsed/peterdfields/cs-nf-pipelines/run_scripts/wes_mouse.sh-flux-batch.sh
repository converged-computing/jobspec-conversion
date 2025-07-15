#!/bin/bash
#FLUX: --job-name=wes_mouse
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow
nextflow ../main.nf \
--workflow wes \
-profile sumner \
--sample_folder <PATH_TO_YOUR_SEQUENCES> \
--gen_org mouse \
--pubdir '/fastscratch/outputDir' \
-w '/fastscratch/outputDir/work' \
--comment "This script will run whole exome sequencing on mouse samples using default mm10"
