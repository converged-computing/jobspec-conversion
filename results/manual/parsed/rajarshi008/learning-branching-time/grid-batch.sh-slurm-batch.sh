#!/bin/bash
#SBATCH --output=hostname_%A_%a.out
#SBATCH --error=hostname_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:00:45
#SBATCH --array=1-168
#SBATCH --nodelist=spyder[06-09]

folder="test_suite/mod_large_random/Kripke/" # specify the folder on which to run on
sample_files=($(find "$folder" -type f -name "*.sp"))
echo "Sample files:"
for sample_file in "${sample_files[@]}"; do
	echo "  $sample_file"
done
current_sample_file=${sample_files[($SLURM_ARRAY_TASK_ID - 1)]}
python learn_formulas.py -f "$current_sample_file"
