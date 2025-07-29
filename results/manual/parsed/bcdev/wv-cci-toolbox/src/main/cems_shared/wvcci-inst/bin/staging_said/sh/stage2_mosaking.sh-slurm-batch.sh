#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bcdev/wv-cci-toolbox/src/main/cems_shared/wvcci-inst/bin/staging_said/sh/stage2_mosaking.sh
