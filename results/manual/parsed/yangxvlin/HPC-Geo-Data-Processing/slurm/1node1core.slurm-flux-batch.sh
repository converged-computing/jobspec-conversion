#!/bin/bash
#FLUX: --job-name=moolicious-kerfuffle-9282
#FLUX: --queue=physical
#FLUX: -t=86400
#FLUX: --priority=16

cd /home/$USER/COMP90024/HPC-Geo-Data-Processing/slurm
module load Python/3.6.1-intel-2017.u2
time mpirun python3 "../src/main.py" -country "../src/language.json" -data "../data/bigTwitter.json"
