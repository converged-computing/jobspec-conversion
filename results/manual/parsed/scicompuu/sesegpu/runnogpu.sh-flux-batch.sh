#!/bin/bash
#FLUX --job-name=blank-kerfuffle-4260
#FLUX -n=4
#FLUX --queue=devcore
#FLUX -t=3540
#FLUX --urgency=16

singularity run /proj/g2020014/nobackup/private/$@
