#!/bin/bash
#SBATCH --job-name=bact_assembly
#SBATCH --output=bact_assembly_snk.out
#SBATCH --error=bact_assembly_snk.err
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=2-23:00:00

SNK_DIR="/hpcfs/users/a1667917/Bacteria_Multiplex/Nanopore_Bacterial_Assembly_Pipeline"
PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 1 -s runner.smk --use-conda --profile $PROF_DIR/bact_assembly --conda-frontend conda \
--config csv=bardy_metadata.csv Output=/hpcfs/users/a1667917/Bacteria_Multiplex/Bardy_Assembly_Output Polypolish_Dir=/hpcfs/users/a1667917/Polypolish min_chrom_length=2400000
conda deactivate
