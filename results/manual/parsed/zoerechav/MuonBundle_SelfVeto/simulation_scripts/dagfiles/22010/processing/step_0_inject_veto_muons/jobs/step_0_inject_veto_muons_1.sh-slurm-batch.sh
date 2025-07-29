#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zoerechav/MuonBundle_SelfVeto/simulation_scripts/dagfiles/22010/processing/step_0_inject_veto_muons/jobs/step_0_inject_veto_muons_1.sh
