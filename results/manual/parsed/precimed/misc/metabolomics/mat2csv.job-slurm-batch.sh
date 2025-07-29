#!/bin/bash
#SBATCH --job-name=mat2csv
#SBATCH --account=p33
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8GB
#SBATCH --time=04:20:00
#SBATCH --array=1-22

module purge
source /cluster/projects/p33/users/mohammadzr/envs/pynext38/bin/activate
python ../mostest_code/pvals2csv_touse.py --mat ../../lipids/europeans/mostest/nmr_eur_${SLURM_ARRAY_TASK_ID}.mat --bim ../../lipids/europeans/zscores/glm_original_combined_zscore.csv_bim_as_ref.csv --n ../../lipids/europeans/zscores/n_max_nmr249_eur.csv --out ../lipids/europeans/mostest/nmr_eur_${SLURM_ARRAY_TASK_ID}.mat.csv
echo 'Done'
