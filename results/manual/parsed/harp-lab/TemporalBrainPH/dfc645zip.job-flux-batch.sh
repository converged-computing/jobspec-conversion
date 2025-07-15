#!/bin/bash
#FLUX: --job-name=dfc645zip
#FLUX: -c=12
#FLUX: --queue=amd-hdr100
#FLUX: -t=18000
#FLUX: --priority=16

set -e
cd /home/ashovon/newaumri/matfiles/
zip -r dfc_645_normal_original.zip dfc_645_normal_original/
