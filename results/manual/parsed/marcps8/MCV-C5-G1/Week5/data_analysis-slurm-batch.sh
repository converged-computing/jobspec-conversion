#!/bin/bash
#FLUX: --job-name=dinosaur-gato-0492
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python data_analysis_verbs.py
