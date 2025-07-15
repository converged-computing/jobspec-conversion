#!/bin/bash
#FLUX: --job-name=training
#FLUX: -c=16
#FLUX: --queue=alpha
#FLUX: -t=43200
#FLUX: --urgency=16

export $(cut -d=' -f1 "$CFG_FILE")'

module switch release/23.04
module load GCCcore/12.2.0
module load Python/3.10.8
module load CUDA/11.8.0
nvidia-smi
CFG_FILE=$1
source "$CFG_FILE"
export $(cut -d= -f1 "$CFG_FILE")
source $VENV_DIR/bin/activate
python -m connectomics_segmentation.train "${@:2}"
