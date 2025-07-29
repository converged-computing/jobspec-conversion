#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/benkirk/bugreports/derecho/pio_lustre_perf/runme-forge.sh
