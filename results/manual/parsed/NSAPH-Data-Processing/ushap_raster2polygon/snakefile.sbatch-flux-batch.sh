#!/bin/bash
#FLUX: --job-name=chocolate-squidward-3563
#FLUX: -c=4
#FLUX: --queue=serial_requeue
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake --cores 1
