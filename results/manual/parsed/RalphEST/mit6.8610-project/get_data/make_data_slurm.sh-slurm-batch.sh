#!/bin/bash
#SBATCH --output=slurm_jobs/%j.out
#SBATCH --error=slurm_jobs/%j.err
#SBATCH --mail-user=ralphestanboulieh@hms.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=60G
#SBATCH --time=00:05:00
#SBATCH --partition=priority

module load gcc/9.2.0 bcftools/1.14 conda3 plink2/2.0
ukbbdir=/n/groups/marks/databases/ukbiobank/ukbb_450k
bash make_data.sh ../data/temp \
                    ../data/data \
                    ../gene_list.txt \
                    $ukbbdir/pop_vcf \
                    $ukbbdir/vep \
                    ../figures/init_data_plots
