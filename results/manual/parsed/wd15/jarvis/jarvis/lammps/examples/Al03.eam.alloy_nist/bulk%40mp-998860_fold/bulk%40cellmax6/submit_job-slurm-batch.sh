#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wd15/jarvis/jarvis/lammps/examples/Al03.eam.alloy_nist/bulk%40mp-998860_fold/bulk%40cellmax6/submit_job
