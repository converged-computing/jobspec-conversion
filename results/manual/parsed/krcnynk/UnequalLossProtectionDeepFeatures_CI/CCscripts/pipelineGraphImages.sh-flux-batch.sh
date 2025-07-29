#!/bin/bash
#FLUX --job-name=fat-omelette-0217
#FLUX -t=21600
#FLUX --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py 0 10 0 0
