#!/bin/bash
#FLUX: --job-name=buttery-peanut-8906
#FLUX: -t=21600
#FLUX: --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py 0 10 0 0
