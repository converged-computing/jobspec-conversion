#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hxmhuang/dumped_CIESM/ciesm.model/models/atm/cam/test/system/test_driver.sh
