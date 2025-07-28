#!/bin/bash
#FLUX: --job-name=test
#FLUX: -t=300
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source ~/.bash_profile
module load singularity/3.5.2
singularity shell --cleanenv --no-home -B /home/people/16304643/robochallenge/workspace /home/people/16304643/robochallenge/rrc2021_latest.sif
source /setup.bash
cd /home/people/16304643/robochallenge/workspace
colcon build
source install/local_setup.bash
mpirun -np 2 ros2 run rrc_example_package testenv 2>&1 | tee testenv.log
