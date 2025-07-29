#!/bin/bash
#SBATCH --job-name=CA1
#SBATCH --output=CA1.out
#SBATCH --nodes=1
#SBATCH --ntasks=60
#SBATCH --cpus-per-task=1
#SBATCH --time=00:12:00
#SBATCH --qos=normal

START=$(date)
mpiexec nrniv -mpi -quiet -python run_network.py simulation_config.json
END=$(date)
{ printf "Start: $START \nEnd:   $END\n" & python plot.py & printf "\n\n" & git diff biophys_components/synaptic_models/; }| mail -r gregglickert@mail.missouri.edu -s "CA1 Results" -a raster.png gregglickert@mail.missouri.edu
echo "Done running model at $(date)"
