#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/marco-willi/camera-trap-data-pipeline/machine_learning/jobs/ctc_predict_species_panthera_ss.pbs
