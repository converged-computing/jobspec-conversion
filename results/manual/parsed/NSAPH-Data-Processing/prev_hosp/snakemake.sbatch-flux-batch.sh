#!/bin/bash
#FLUX: --job-name=loopy-lamp-5110
#FLUX: --urgency=16

date #print start time
snakemake --cores 6
date #print end time
