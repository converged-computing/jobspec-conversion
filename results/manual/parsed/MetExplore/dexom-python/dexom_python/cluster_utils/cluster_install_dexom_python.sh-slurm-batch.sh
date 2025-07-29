#!/bin/bash
#SBATCH --job-name=cluster_install
#SBATCH --output=cluster_install_out.out
#SBATCH --error=cluster_install_err.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

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
