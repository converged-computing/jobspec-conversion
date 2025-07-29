#!/bin/bash
#FLUX: --job-name=pytorch_example
#FLUX: -c=8
#FLUX: --queue=v100
#FLUX: -t=3600
#FLUX: --urgency=16

jupyter notebook --ip=0.0.0.0 --port=3001 --no-browser
