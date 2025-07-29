#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/susburrows/cam5_3_38/models/atm/cam/test/system/test_driver.sh
