#!/bin/bash
#FLUX: --job-name=will_bact_assembly
#FLUX: --queue=batch
#FLUX: -t=255600
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
mkdir -p /hpcfs/users/a1667917/Will
snakemake -c 1 -s runner.smk --use-conda --profile $PROF_DIR/bact_assembly --conda-frontend conda \
--config csv=old_metadata/will_martha.csv Staph=False Output=/hpcfs/users/a1667917/Will/C_Accolens_Martha_Hybrid_Assembly_Output Polypolish_Dir=/hpcfs/users/a1667917/Polypolish min_chrom_length=2000000
conda deactivate
