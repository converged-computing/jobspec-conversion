#!/bin/bash
#FLUX: --job-name=platipus
#FLUX: -n=4
#FLUX: --queue=gtx
#FLUX: -t=28800
#FLUX: --urgency=16

ibrun --multi-prog
