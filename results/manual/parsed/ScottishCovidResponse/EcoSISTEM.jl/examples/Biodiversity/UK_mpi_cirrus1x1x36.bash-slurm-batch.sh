#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ScottishCovidResponse/EcoSISTEM.jl/examples/Biodiversity/UK_mpi_cirrus1x1x36.bash
