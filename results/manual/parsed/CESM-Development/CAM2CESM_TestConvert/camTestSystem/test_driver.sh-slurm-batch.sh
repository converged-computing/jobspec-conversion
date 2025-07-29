#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CESM-Development/CAM2CESM_TestConvert/camTestSystem/test_driver.sh
