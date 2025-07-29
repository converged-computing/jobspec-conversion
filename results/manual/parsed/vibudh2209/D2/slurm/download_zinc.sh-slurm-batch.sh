#!/bin/bash
#FLUX: --job-name=download_zinc
#FLUX: --urgency=16

source tensorflow_gpu/bin/activate
python download_zinc15.py -up $1 -fp $2 -fn $3  -tp $4
