#!/bin/bash
#FLUX: --job-name=Scrape
#FLUX: --queue=epyc2
#FLUX: -t=1296000
#FLUX: --urgency=16

python ejustice.py
