#!/bin/bash
#SBATCH --job-name=pseud_bact_assembly
#SBATCH --output=complete_pseud_rudnick.out
#SBATCH --error=complete_pseud_rudnick.err
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=2-23:00:00

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="$SNK_DIR/snakemake_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 16 -s runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/assembly  --config csv=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/all_pseudomonas_metadata_rudnick.csv Output=/hpcfs/users/a1667917/Rudnick_Timepoint_Analysis/Output_Psuedomonas Staph=False min_chrom_length=5500000
conda deactivate
