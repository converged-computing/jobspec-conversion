#!/bin/bash
#FLUX --job-name=eccentric-destiny-2484
#FLUX -c=4
#FLUX --queue=serial_requeue
#FLUX -t=86400
#FLUX --urgency=16

snakemake --cores 1
