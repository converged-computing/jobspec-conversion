#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/comgsi/GSI/util/Radiance_Monitor/nwprod/nam_radmon/driver/test_jnam_verfrad_cray.sh
