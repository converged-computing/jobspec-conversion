#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/maciejjanecki/ff-development/cesm1_0_1/models/lnd/clm/test/system/test_driver.sh
