#!/bin/bash
#SBATCH --job-name=dataaug-en
#SBATCH --output=output_en.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40gb
#SBATCH --time=18:00:00
#SBATCH --array=1-4

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
