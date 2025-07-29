#!/bin/bash
#FLUX: --job-name=molsim_hw3
#FLUX: -n=2
#FLUX: --queue=pfaendtner
#FLUX: -t=1800
#FLUX: --urgency=16

cat conditions.txt | while read line; do
  echo $line
done
