#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2021_NatMater_v20_p1015_HighRateIntrusionZIFs/NPT_forcefield_yaff/scripts/water_gradient/zif8_1-1-2_H2O_1-1-05/job_restart.sh
