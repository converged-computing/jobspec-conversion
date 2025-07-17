#!/bin/bash
#FLUX: --job-name=doopy-hobbit-2961
#FLUX: --urgency=16

export CONDA_ALWAYS_YES='true'

source "$(dirname $(dirname $(which conda)))"/etc/profile.d/conda.sh
TURNKEY_PATH=${1:-"$PWD"}
ENV_NAME=${2:-tracker_slurm}
export CONDA_ALWAYS_YES="true"
if { conda env list | grep "$ENV_NAME "; } >/dev/null 2>&1; then
    echo "$ENV_NAME already exists - Not creating it from scratch"
else
    echo "Creating $ENV_NAME"
    conda create -n "$ENV_NAME" python=3.8
fi
unset CONDA_ALWAYS_YES
conda activate "$ENV_NAME"
python -m pip install --upgrade pip
if [[ "$TORCH_CPU" == "True" ]]; then
    pip install torch -f https://download.pytorch.org/whl/cpu/torch_stable.html
fi
cd "$TURNKEY_PATH" || exit
pip install -e .
if [[ "$SKIP_REQUIREMENTS_INSTALL" != "True" ]]
then
    cd models || exit
    pip install -r requirements.txt
fi
