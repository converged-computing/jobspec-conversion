#!/bin/bash
#FLUX: --job-name=cluster_install
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
git clone https://forgemia.inra.fr/metexplore/cbm/dexom-python.git dexompython
cd dexompython
module purge
module load system/Python-3.7.4
python -m venv env
source env/bin/activate
pip install --upgrade pip
pip install poetry
poetry install
pip install snakemake
echo "installation complete"
