#!/bin/bash
#FLUX: --job-name=custom_dataset_train
#FLUX: --queue=inferno
#FLUX: -t=86400
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR                            # Change to working directory
module load anaconda3/2022.05                   # Load module dependencies
conda create -n bm ipython python=3.8 -y
conda activate bm
conda install pytorch torchaudio cudatoolkit=11.3 -c pytorch -y
pip install -U -r requirements.txt
pip install -e .
python -m spacy download en_core_web_md
