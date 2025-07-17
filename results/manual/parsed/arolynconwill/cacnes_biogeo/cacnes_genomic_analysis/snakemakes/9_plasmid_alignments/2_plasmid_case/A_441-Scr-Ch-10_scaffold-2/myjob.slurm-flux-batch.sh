#!/bin/bash
#FLUX: --job-name=CaseScaff3.SM.main
#FLUX: --queue=defq
#FLUX: -t=86400
#FLUX: --urgency=16

bash snakemakeslurm.sh
echo Done!!!
