#!/bin/bash
#FLUX: --job-name=persnickety-peanut-4406
#FLUX: -n=40
#FLUX: --queue=small
#FLUX: -t=54610
#FLUX: --urgency=16

module load maestro 
bash script_file.sh
