#!/bin/bash
#FLUX: --job-name=prepare-container
#FLUX: -t=7200
#FLUX: --urgency=16

conda update -n base -c conda-forge conda
conda install -y -c conda-forge -c nvidia merlin-core merlin-models merlin-systems nvtabular transformers4rec tensorflow
pip install graphviz
conda env create -f /mgr/preprocess-datasets-environment.yml
sed -i '2i DISABLE_JUPYTER=true' /opt/docker/bin/entrypoint_source
mkdir -p /mgr/meta-json-parser/build
