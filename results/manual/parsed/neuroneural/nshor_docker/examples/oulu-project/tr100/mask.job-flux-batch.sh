#!/bin/bash
#FLUX: --job-name=anxious-sundae-5162
#FLUX: -t=72000
#FLUX: --urgency=16

module load afni
while IFS= read -r sub_id; do
    # Define the paths to the input files
    input_file="/data/users2/jwardell1/nshor_docker/examples/oulu-project/OULU/${sub_id}/processed/func2mni_warped.nii.gz"
    mask_file="/data/users2/jwardell1/nshor_docker/examples/oulu-project/OULU/${sub_id}/processed/template_mask_3mm.nii.gz"
    # Define the output filename
    output_file="/data/users2/jwardell1/nshor_docker/examples/oulu-project/OULU/${sub_id}/processed/func2mni_masked.nii.gz"
    # Apply the mask using 3dcalc
    3dcalc -a "$input_file" -b "$mask_file" -expr 'a*b' -prefix "$output_file"
    echo "Mask applied for subject ${sub_id}"
done < subjects.txt
