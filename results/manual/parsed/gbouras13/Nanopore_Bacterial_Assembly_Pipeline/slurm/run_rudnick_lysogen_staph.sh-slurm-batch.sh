#!/bin/bash
#FLUX: --job-name=staph_bact_assembly
#FLUX: --queue=batch
#FLUX: -t=255600
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="$SNK_DIR/snakemake_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 16 -s runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/assembly  --config csv=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/all_saureus_metadata_rudnick.csv Output=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/Output min_chrom_length=2500000
conda deactivate
