#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kryczko/qmcpack/tests/test_automation/nightly_test_scripts/nightly_olcf_summit.sh
