#!/bin/bash
#SBATCH --job-name=test_as
#SBATCH --account=b1042
#SBATCH --output=20231102_test_as.log
#SBATCH --mail-user=ryanmckeown2021@u.northwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module load singularity
nextflow run main.nf -profile simulations \
--species c_elegans \
--vcf /projects/b1059/projects/Ryan/NemaScan_Updates/NemaScan/input_data/c_elegans/genotypes/c_elegans.test.rename.vcf.gz \
--simulate_strains /projects/b1059/projects/Ryan/NemaScan_Updates/NemaScan/ce_test.vcf_input.strains.txt \
--simulate_nqtl /projects/b1059/projects/Ryan/Caenorhabditis_GWAS/best_panel_subsample/20231017_CE_96.192_Alloutlier/nqtl.csv \
--simulate_h2 /projects/b1059/projects/Ryan/Caenorhabditis_GWAS/best_panel_subsample/20231017_CE_96.192_Alloutlier/h2.csv \
--simulate_eff /projects/b1059/projects/Ryan/Caenorhabditis_GWAS/best_panel_subsample/20231017_CE_96.192_Alloutlier/effect_sizes.csv \
--simulate_reps 2 \
--out 20231127_execution_test
