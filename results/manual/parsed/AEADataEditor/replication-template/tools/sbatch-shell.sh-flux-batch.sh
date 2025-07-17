#!/bin/bash
#FLUX: --job-name=RunStata
#FLUX: -c=8
#FLUX: -t=30
#FLUX: --urgency=16

/usr/local/stata16/stata-mp -b main.do
