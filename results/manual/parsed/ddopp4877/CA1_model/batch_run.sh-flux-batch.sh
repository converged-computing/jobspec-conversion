#!/bin/bash
#FLUX: --job-name=CA1
#FLUX: -t=720
#FLUX: --priority=16

START=$(date)
mpiexec nrniv -mpi -quiet -python run_network.py simulation_config.json
END=$(date)
{ printf "Start: $START \nEnd:   $END\n" & python plot.py & printf "\n\n" & git diff biophys_components/synaptic_models/; }| mail -r gregglickert@mail.missouri.edu -s "CA1 Results" -a raster.png gregglickert@mail.missouri.edu
echo "Done running model at $(date)"
