#!/bin/bash
#FLUX: --job-name=sticky-hope-7145
#FLUX: --urgency=16

module load python-3.7.1
for i in pori3 hwsd isric10km isric5km isric1km isric250m; do
    $HOME/.conda/envs/daskgeo2020a/bin/python run_for.py -m $i
done
