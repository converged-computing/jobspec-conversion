#!/bin/bash
#FLUX: --job-name=WGAN
#FLUX: -t=345600
#FLUX: --urgency=16

export PATH='$CONDA_ROOT/bin:$PATH'

source $HOME/miniconda3/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate WGAN
module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
python run_cwgangp.py
