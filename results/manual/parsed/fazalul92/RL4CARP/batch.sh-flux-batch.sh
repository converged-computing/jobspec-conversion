#!/bin/bash
#FLUX: --job-name=Citizenly-RL-SnowPlowing
#FLUX: -c=2
#FLUX: --queue=tier3
#FLUX: -t=43200
#FLUX: --urgency=16

spack env activate ml-geo-20070801
echo " (${HOSTNAME}) Job Running..."
python3 trainer.py --task=vrp --nodes=50
echo " *(${HOSTNAME}) Job completed. "
