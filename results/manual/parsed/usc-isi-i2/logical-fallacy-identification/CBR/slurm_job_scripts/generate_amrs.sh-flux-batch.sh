#!/bin/bash
#FLUX: --job-name=generate_amr_graphs
#FLUX: -c=16
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python cbr_analyser.amr.amr_extraction \
    --input_file ${input_file} \
    --output_file ${output_file} \
    --task amr_generation
conda deactivate
