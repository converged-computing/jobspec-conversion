#!/bin/bash
#FLUX: --job-name=dinosaur-general-6523
#FLUX: --priority=16

source $HOME/loadenv_gpu.sh
cd /c3se/users/zrimec/Vera/projects/DeepExpression/2019_3_22
snakemake -j 1 > _run_hyperas_scerevisiae_codons.log
