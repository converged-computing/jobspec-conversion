#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/alexjvr1/VelocityUCL/VelocityPipeline/wrapper/03a_call_SNVs_bluecp3.sh
