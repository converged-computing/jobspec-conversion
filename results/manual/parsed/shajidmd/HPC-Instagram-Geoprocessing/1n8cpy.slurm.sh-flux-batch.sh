#!/bin/bash
#FLUX: --job-name=rainbow-dog-3132
#FLUX: -n=8
#FLUX: --queue=physical
#FLUX: -t=600
#FLUX: --priority=16

module load Python/3.5.2-goolf-2015a
echo "Cluster and Cloud Computing Assignment1 using 1 node and 8 cores"
time mpiexec python3 HPCInstagramGeoProcessingUsingMPI.py melbGrid.json bigInstagram.json
