#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/rna-espaloma/experiment/nucleoside/espaloma-0.3.0rc6/adenosine/eq/submit.sh
