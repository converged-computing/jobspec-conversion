#!/bin/bash
#FLUX: --job-name=wes_mouse
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow/23.10.1
nextflow ../main.nf \
--workflow wes \
-profile sumner2 \
--sample_folder <PATH_TO_YOUR_SEQUENCES> \
--gen_org mouse \
--genome_build 'GRCm38' \
--pubdir "/flashscratch/${USER}/outputDir" \
-w "/flashscratch/${USER}/outputDir/work" \
--comment "This script will run whole exome sequencing analysis on mouse samples using default mm10"
