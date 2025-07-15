#!/bin/bash
#FLUX: --job-name=gassy-snack-7847
#FLUX: --urgency=16

folder="test_suite/mod_large_random/Kripke/" # specify the folder on which to run on
sample_files=($(find "$folder" -type f -name "*.sp"))
echo "Sample files:"
for sample_file in "${sample_files[@]}"; do
	echo "  $sample_file"
done
current_sample_file=${sample_files[($SLURM_ARRAY_TASK_ID - 1)]}
python learn_formulas.py -f "$current_sample_file"
