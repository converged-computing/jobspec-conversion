#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/meteorologytoday/EMOM/formal_project/02_derive_qflx_direct/run_MLM.sh
