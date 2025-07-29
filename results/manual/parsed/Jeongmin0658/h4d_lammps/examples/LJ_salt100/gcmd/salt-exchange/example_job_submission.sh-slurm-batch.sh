#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Jeongmin0658/h4d_lammps/examples/LJ_salt100/gcmd/salt-exchange/example_job_submission.sh
