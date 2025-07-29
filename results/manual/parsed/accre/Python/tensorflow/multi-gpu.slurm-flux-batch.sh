#!/bin/bash
#FLUX --job-name=spicy-lemur-3534
#FLUX --queue=maxwell
#FLUX -t=43200
#FLUX --urgency=16

setpkgs -a tensorflow_0.11.0rc0
python fit-line.py
