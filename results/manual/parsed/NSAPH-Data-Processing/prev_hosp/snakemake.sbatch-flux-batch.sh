#!/bin/bash
#FLUX: --job-name=placid-hobbit-0207
#FLUX: -c=8
#FLUX: --queue=fasse
#FLUX: -t=720
#FLUX: --urgency=16

date #print start time
snakemake --cores 6
date #print end time
