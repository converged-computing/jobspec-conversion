#!/bin/bash
#FLUX: --job-name=electra
#FLUX: -n=28
#FLUX: --queue=adaptlab
#FLUX: -t=43200
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/home/kbhetwal/child-electra/electra-pytorch'

module load slurm
module load cuda10.2
source  "/home/kbhetwal/anaconda3/etc/profile.d/conda.sh"
conda activate torch
export PYTHONPATH=${PYTHONPATH}:/home/kbhetwal/child-electra/electra-pytorch
python examples/glue/run.py  --model_type electra --model_name_or_path google/electra-large-discriminator --data_dir data/glue_data/MRPC  --task_name MRPC --output_dir output/MRPC_electra_large
python examples/glue/run.py  --model_type electra  --model_name_or_path google/electra-large-discriminator --data_dir data/glue_data/CoLA  --task_name CoLA --output_dir output/cola_electra_large
python examples/glue/run.py   --model_type electra --model_name_or_path google/electra-base-discriminator --data_dir data/glue_data/WNLI  --task_name WNLI --output_dir output/wnli_electra_large
status=$?
if [ $status -ne 0 ]; then
    exit $status
fi
