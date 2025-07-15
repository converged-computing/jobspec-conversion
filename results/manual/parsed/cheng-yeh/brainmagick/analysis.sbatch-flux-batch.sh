#!/bin/bash
#FLUX: --job-name=psycho-leopard-2503
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR                            # Change to working directory
module load anaconda3/2022.05                   # Load module dependencies
conda create -n bm ipython python=3.8 -y
conda activate bm
conda install pytorch==1.12.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch
pip install -U -r requirements.txt
pip install -e .
python -m spacy download en_core_web_md
python analysis.py
