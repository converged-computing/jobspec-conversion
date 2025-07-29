#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/opentargets/genetics-backend/reference_data/uk_biobank_v3/queue_to_farm.sh
