#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bakerccm/300TestTeaching/scripts/300test_AdapterRemoval_to_DAMe_Metabarcoding_pipeline_for_teaching_macOS.sh
