#!/bin/bash
#FLUX: --job-name=synth_gen_pan_TCGA
#FLUX: --queue=gpu --gres gpu:1
#FLUX: -t=7200
#FLUX: --priority=16

source project_root/bin/activate
python HLVS.py 'output_dir_name/' '/train_file_path/*.tsv' $1 40 10 150
