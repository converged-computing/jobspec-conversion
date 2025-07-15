#!/bin/bash
#FLUX: --job-name="HW6 CS 601.471/671 homework"
#FLUX: --queue=a100
#FLUX: -t=43200
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/scratch4/danielk/schaud31'

module load anaconda
export TRANSFORMERS_CACHE=/scratch4/danielk/schaud31
conda activate toy_classification_env # open the Python environment
conda config --set allow_conda_downgrades true
conda install -c conda-forge faiss-gpu
conda install faiss-gpu
pip cache purge
pip install torch torchvision torchaudio
pip install -r requirements.txt
pip install petals
conda config --set allow_conda_downgrades false
srun python petals_bloomz.py --experiment "petals_finetuned" --model "bigscience/bloomz-560m" --small_subset True --batch_size "1" --lr 1e-4 --num_epochs 3
