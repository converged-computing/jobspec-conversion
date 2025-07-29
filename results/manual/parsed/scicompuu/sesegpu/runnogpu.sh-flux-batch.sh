#!/bin/bash
#FLUX --job-name=misunderstood-general-5287
#FLUX -n=4
#FLUX --queue=devcore
#FLUX -t=3540
#FLUX --urgency=16

singularity run /proj/g2020014/nobackup/private/$@
