#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

module load Python/3.5.2-goolf-2015a
echo "Cluster and Cloud Computing Assignment1 using 1 node and 8 cores"
time mpiexec python3 HPCInstagramGeoProcessingUsingMPI.py melbGrid.json bigInstagram.json
