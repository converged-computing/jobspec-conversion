#!/bin/bash
#FLUX: --job-name=n00n
#FLUX: --urgency=16

module load 2021
module load Julia/1.6.1-linux-x86_64
mkdir "$TMPDIR"/function_environment
mkdir -p "$TMPDIR"/output_dir_par
cp -r "$HOME"/JULIA/Leaves/all_functions_5d.jl "$TMPDIR"/function_environment  #upload all functions to function environment
cp -r "$HOME"/JULIA/Leaves/iterators_and_parameters.jl "$TMPDIR"/function_environment  #upload all functions to function environment
for no_leaves in `seq 0 1`; do
                                julia "$HOME"/JULIA/Leaves/one_run_and_save_full.jl  5 5 $no_leaves  -1  "$TMPDIR"/function_environment/ "$TMPDIR"/output_dir_par/ &
done
wait
cp -r -u  "$TMPDIR"/output_dir_par "$HOME"/JULIA/Leaves/outputs
echo "copying done"
