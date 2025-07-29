#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pedrocrisp/springerlab_methylation/SeqCap/05-summarise_methylation.sh
