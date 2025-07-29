#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AkirisMc/thesis-FL16-pipeline/s01_installation_and_testing/s01_clone_pb_16s_nf_pipeline.sh
