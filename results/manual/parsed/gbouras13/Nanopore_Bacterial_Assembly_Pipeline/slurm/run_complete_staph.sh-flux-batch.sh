#!/bin/bash
#FLUX: --job-name=bact_assembly
#FLUX: -t=255600
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="$SNK_DIR/snakemake_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 1 -s runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/assembly  \
--config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/Staph_Final_Assemblies_14_11_22 min_chrom_length=2500000 
conda deactivate
