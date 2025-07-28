#!/bin/bash
#FLUX: --job-name=blank-ricecake-9978
#FLUX: -c=4
#FLUX: --queue=serial_requeue
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake --cores 1
