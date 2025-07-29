#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ECCC-ASTD-MRD/MIDAS-src/maestro/suites/midas_system_tests/modules/UnitTest/scripts/launch_interactive.sh
