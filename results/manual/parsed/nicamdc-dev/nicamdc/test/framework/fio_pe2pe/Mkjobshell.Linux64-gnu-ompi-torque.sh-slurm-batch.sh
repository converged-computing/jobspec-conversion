#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/nicamdc-dev/nicamdc/test/framework/fio_pe2pe/Mkjobshell.Linux64-gnu-ompi-torque.sh
