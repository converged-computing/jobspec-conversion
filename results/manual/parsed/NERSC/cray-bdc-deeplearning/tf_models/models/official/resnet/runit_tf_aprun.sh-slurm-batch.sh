#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NERSC/cray-bdc-deeplearning/tf_models/models/official/resnet/runit_tf_aprun.sh
