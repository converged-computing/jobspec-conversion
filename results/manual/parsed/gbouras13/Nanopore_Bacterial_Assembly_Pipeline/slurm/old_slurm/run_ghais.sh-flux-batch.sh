#!/bin/bash
#FLUX: --job-name=bact_assembly
#FLUX: -t=255600
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 1 -s runner.smk --use-conda --conda-frontend conda --profile $PROF_DIR/bact_assembly \
--config csv=ghais_hpc_metadata.csv Output=/hpcfs/users/a1667917/Ghais/S_Aureus_Polished/Assembly_Output Polypolish_Dir=/hpcfs/users/a1667917/Polypolish min_chrom_length=2400000
conda deactivate
