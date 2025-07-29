#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2021_NatMater_v20_p1015_HighRateIntrusionZIFs/NPT_forcefield_yaff/scripts/water_gradient/zif8_2-2-6_H2O_2-2-3/job_restart.sh
