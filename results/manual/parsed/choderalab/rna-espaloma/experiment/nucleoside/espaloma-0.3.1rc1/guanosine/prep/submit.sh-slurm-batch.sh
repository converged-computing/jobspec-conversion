#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/rna-espaloma/experiment/nucleoside/espaloma-0.3.1rc1/guanosine/prep/submit.sh
