#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/munoztd0/OBIWAN/BIDS/import_dicom/matlab_run.sh
