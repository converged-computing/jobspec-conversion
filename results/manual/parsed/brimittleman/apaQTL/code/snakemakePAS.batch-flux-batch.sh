#!/bin/bash
#FLUX: --job-name=snakemakePAS
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --priority=16

bash submit-snakemakePAS.sh $*
