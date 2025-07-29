#!/bin/bash
#SBATCH --job-name=prepare-container
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=02:00:00
#SBATCH --constraint=dgx,ntasks-per-node=1

conda update -n base -c conda-forge conda
conda install -y -c conda-forge -c nvidia merlin-core merlin-models merlin-systems nvtabular transformers4rec tensorflow
pip install graphviz
conda env create -f /mgr/preprocess-datasets-environment.yml
sed -i '2i DISABLE_JUPYTER=true' /opt/docker/bin/entrypoint_source
mkdir -p /mgr/meta-json-parser/build
