#!/bin/bash
#FLUX: --job-name=torch-test
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --urgency=16

conda activate covidqa
echo $(pwd)
./scripts/squad1/roberta_base_ce_2gpu.sh
