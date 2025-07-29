#!/bin/bash
#SBATCH --job-name=staph_bact_assembly
#SBATCH --output=complete_staph_rudnick.out
#SBATCH --error=complete_staph_rudnick.err
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=2-23:00:00
#SBATCH --partition=batch

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="$SNK_DIR/snakemake_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 16 -s runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/assembly  --config csv=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/all_saureus_metadata_rudnick.csv Output=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/Output min_chrom_length=2500000
conda deactivate
