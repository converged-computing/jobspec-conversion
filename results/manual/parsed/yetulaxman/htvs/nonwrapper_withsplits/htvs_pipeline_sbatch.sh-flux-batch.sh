#!/bin/bash
#FLUX: --job-name=carnivorous-taco-7730
#FLUX: -n=40
#FLUX: --queue=small
#FLUX: -t=54610
#FLUX: --urgency=16

module load maestro 
bash script_file.sh
