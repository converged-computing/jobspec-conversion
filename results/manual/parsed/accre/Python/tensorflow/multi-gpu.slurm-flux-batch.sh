#!/bin/bash
#FLUX: --job-name=chocolate-fudge-1280
#FLUX: --queue=maxwell
#FLUX: -t=43200
#FLUX: --urgency=16

setpkgs -a tensorflow_0.11.0rc0
python fit-line.py
