#!/bin/bash
#FLUX: --job-name=chocolate-plant-5696
#FLUX: --queue=physical
#FLUX: -t=600
#FLUX: --priority=16

module load Python/3.5.2-goolf-2015a
echo "Cluster and Cloud Computing Assignment1 using 1 node and 1 core"
time mpiexec python3 HPCInstagramGeoProcessingUsingMPI.py melbGrid.json bigInstagram.json
