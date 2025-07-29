#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/marco-willi/camera-trap-data-pipeline/machine_learning/jobs/ctc_create_panthera_tfrecords.pbs
