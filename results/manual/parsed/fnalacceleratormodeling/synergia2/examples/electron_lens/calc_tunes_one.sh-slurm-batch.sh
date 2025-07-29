#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/fnalacceleratormodeling/synergia2/examples/electron_lens/calc_tunes_one.sh
