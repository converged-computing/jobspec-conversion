#!/bin/bash
#FLUX: --job-name=chocolate-pastry-4123
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: --urgency=16

source activate mlfold
folder_with_pdbs="../inputs/PDB_monomers/pdbs/"
output_dir="../outputs/example_1_outputs"
if [ ! -d $output_dir ]
then
    mkdir -p $output_dir
fi
path_for_parsed_chains=$output_dir"/parsed_pdbs.jsonl"
python ../helper_scripts/parse_multiple_chains.py --input_path=$folder_with_pdbs --output_path=$path_for_parsed_chains
python ../protein_mpnn_run.py \
        --jsonl_path $path_for_parsed_chains \
        --out_folder $output_dir \
        --num_seq_per_target 2 \
        --sampling_temp "0.1" \
        --seed 37 \
        --batch_size 1
