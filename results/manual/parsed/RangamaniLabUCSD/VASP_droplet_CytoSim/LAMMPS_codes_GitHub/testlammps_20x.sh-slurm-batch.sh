#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/RangamaniLabUCSD/VASP_droplet_CytoSim/LAMMPS_codes_GitHub/testlammps_20x.sh
