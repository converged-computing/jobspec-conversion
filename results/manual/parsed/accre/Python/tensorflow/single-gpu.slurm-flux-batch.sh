#!/bin/bash
#FLUX: --job-name=delicious-milkshake-3341
#FLUX: --queue=maxwell
#FLUX: -t=43200
#FLUX: --urgency=16

setpkgs -a tensorflow_0.11.0rc0
python fit-line.py
