#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/E3SM-Project/iESM/models/lnd/clm/test/system/test_driver.sh
