#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/radix-io/io-sleuthing/examples/striping/polaris/ior-stripes.sh
