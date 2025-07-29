#!/bin/bash
#FLUX: --job-name=morse
#FLUX: -c=4
#FLUX: --queue=es1
#FLUX: -t=345600
#FLUX: --urgency=16

source activate newtonnet
python ~/NewtonNet/cli/newtonnet_train -c ~/20230120_AnalPES/config.yml
