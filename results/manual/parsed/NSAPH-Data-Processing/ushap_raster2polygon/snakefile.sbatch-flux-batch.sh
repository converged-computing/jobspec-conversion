#!/bin/bash
#FLUX --job-name=persnickety-leg-8839
#FLUX -c=4
#FLUX --queue=serial_requeue
#FLUX -t=86400
#FLUX --urgency=16

snakemake --cores 1
