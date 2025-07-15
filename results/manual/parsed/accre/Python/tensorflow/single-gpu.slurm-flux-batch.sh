#!/bin/bash
#FLUX: --job-name=blue-fudge-9883
#FLUX: --queue=maxwell
#FLUX: -t=43200
#FLUX: --priority=16

setpkgs -a tensorflow_0.11.0rc0
python fit-line.py
