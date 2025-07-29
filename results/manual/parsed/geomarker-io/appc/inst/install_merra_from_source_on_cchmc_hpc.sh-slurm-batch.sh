#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geomarker-io/appc/inst/install_merra_from_source_on_cchmc_hpc.sh
