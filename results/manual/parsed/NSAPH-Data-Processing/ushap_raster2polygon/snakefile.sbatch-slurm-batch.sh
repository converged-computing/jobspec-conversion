#!/bin/bash
#FLUX: --job-name=wobbly-leopard-3884
#FLUX: -c=4
#FLUX: --queue=serial_requeue
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake --cores 1
