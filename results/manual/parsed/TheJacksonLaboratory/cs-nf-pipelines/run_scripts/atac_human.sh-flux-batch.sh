#!/bin/bash
#FLUX: --job-name=atac_human
#FLUX: --queue=batch
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow/23.10.1
nextflow ../main.nf \
--workflow atac \
-profile sumner2 \
--sample_folder <PATH_TO_YOUR_SEQUENCES> \
--gen_org human \
--genome_build 'GRCh38' \
--pubdir "/flashscratch/${USER}/outputDir" \
-w "/flashscratch/${USER}/outputDir/work" \
--comment "This script will run atac sequencing analysis on human samples using default hg38"
