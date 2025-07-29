#!/bin/bash
#SBATCH --job-name=TACT_3rd
#SBATCH --account=PDiv
#SBATCH --mail-user=melanie.tietje@bio.au.dk
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=150gb
#SBATCH --time=5-00:00:00
#SBATCH --partition=normal
#SBATCH --array=301-351

source ~/miniconda3/bin/activate tact
echo -e "\nrunning TACT\n"
singularity exec tact.sif  tact_add_taxa --backbone gbmb_matched_monophyletic_orders.tre --taxonomy goodsp_wcp_2022_forTACT.taxonomy.tre --output output/gbmb_matched_monophyletic_orders_$SLURM_JOB_ID-$SLURM_ARRAY_TASK_ID.tacted --verbose
echo -e "\nfinished TACT\n"
