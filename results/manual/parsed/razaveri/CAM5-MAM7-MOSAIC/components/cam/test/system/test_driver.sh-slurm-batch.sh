#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/razaveri/CAM5-MAM7-MOSAIC/components/cam/test/system/test_driver.sh
