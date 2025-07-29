#!/bin/bash
#SBATCH --job-name=electra
#SBATCH --output=electra1.log
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

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
