#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell
#SBATCH --array=0-2

module load ParaView
start_pvbatch.sh 1 1 haswell 00:1:00 default debug `pwd`/pv-test.py
