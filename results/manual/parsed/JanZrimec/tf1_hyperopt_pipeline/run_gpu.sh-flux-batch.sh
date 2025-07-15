#!/bin/bash
#FLUX: --job-name=conspicuous-banana-3272
#FLUX: --urgency=16

source $HOME/loadenv_gpu.sh
cd /c3se/users/zrimec/Vera/projects/DeepExpression/2019_3_46
snakemake -j 1 > _run_hyperas_scerevisiae_nostab.log  
