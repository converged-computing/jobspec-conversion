#!/bin/bash
#FLUX: --job-name=bumfuzzled-avocado-5749
#FLUX: -c=4
#FLUX: -t=82800
#FLUX: --urgency=16

module purge
module load anaconda/3/2021.11
module load cuda/11.6
module load pytorch/gpu-cuda-11.6/1.12.0
module load scikit-learn/1.1.1
pip install --user pandas
pip install --user numpy
pip install --user libclang
pip install --user transformers
pip install --user wandb
pip install --user evaluate
pip install --user torchtext
pip install --user pytorch-lightning
pip install --user nltk
pip install --user sentencepiece
srun python icse2024_experiments/scripts/VulDeePecker/PLBart/run.py $*
echo "job finished"
