#!/bin/bash
#FLUX: --job-name=singnbconv
#FLUX: --queue=celltypes
#FLUX: -t=180000
#FLUX: --priority=16

source ~/.bashrc
!nvidia-smi
conda activate antipode
NOTEBOOK=/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/Team/Matthew/code/scANTIPODE/examples/1.9.1.8.3_JorstadAll-NoReLU.ipynb
jupyter nbconvert --ExecutePreprocessor.allow_errors=True --to html --execute "${NOTEBOOK}" --output ~/Matthew/code/scANTIPODE/examples/outputs/"executed_$(basename "${NOTEBOOK}")" 
