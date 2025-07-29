#!/bin/bash
#SBATCH --job-name=pvpython
#SBATCH --account=sxs
#SBATCH --output=SpEC.stdout
#SBATCH --error=SpEC.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH: --no-requeue

/panfs/ds09/sxs/himanshu/softwares/ParaView-5.10.0-osmesa-MPI-Linux-Python3.9-x86_64/bin/pvpython /panfs/ds09/sxs/himanshu/scripts/plotting/paraview/load_and_take_slice.py
