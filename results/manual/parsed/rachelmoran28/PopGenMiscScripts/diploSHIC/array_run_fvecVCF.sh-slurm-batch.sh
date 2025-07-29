#!/bin/bash
#SBATCH --job-name=fvecVCF
#SBATCH --output=CMS_fvecVCF.out
#SBATCH --error=CMS_fvecVCF.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=230gb
#SBATCH --time=1-04:00:00
#SBATCH --partition=ram256g,ram1t,amd2tb,amdlarge,amdsmall,small,astyanax,cavefish
#SBATCH --array=1001-2360

source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo
cd /home/mcgaughs/shared/Software/diploSHIC
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/combined_filtered/250_samples"
Pop="CabMoroSurface"
CMD_LIST="HardFiltered_All_wInvar_Commands_fvecVCF_5kb.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
