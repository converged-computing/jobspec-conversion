#!/bin/bash
#SBATCH --job-name=fvecVCF
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=62gb
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-26

source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo
cd /home/mcgaughs/shared/Software/diploSHIC
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/filtered_snps/HardFilteredSNPs_250Samples"
Pop="Tinaja"
CMD_LIST="HardFiltered_All_Commands_fvecVCF.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
