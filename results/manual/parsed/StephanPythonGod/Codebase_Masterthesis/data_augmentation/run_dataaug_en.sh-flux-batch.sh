#!/bin/bash
#FLUX: --job-name=dataaug-en
#FLUX: --queue=gpu_4
#FLUX: -t=64800
#FLUX: --urgency=16

echo "Starting ..."
module load devel/cuda/11.8
module load devel/python/3.8.6_gnu_10.2
echo "Modules loaded"
if [ ! -d "venv-python3" ]; then
    echo "Creating Venv"
    python -m venv venv-python3
fi
. venv-python3/bin/activate
echo "Virutal Env Activated"
pip install --upgrade pip
pip install pymongo transformers torch google-cloud-storage
pip install optimum>=1.12.0
pip install auto-gptq --extra-index-url https://huggingface.github.io/autogptq-index/whl/cu118/  # Use cu117 if on CUDA 11.7
echo "Installed Dependencies"
ARRAY_INDEX=$SLURM_ARRAY_TASK_ID
python3 data_augmentation_english.py $ARRAY_INDEX >  py_output_en_$ARRAY_INDE.txt 2>&1
echo "Script ran through"
deactivate
