#!/bin/bash
#FLUX: --job-name=stinky-poodle-2879
#FLUX: -t=21600
#FLUX: --priority=16

module restore uneq
cd ..
python Korcan/pipeline.py 0 10 0 0
