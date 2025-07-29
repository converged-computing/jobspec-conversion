#!/bin/bash
#SBATCH --job-name=State_Report_Maps
#SBATCH --output=/cluster/home/jdesch01/coi-maps/logs/log_%A.txt
#SBATCH --mail-user=john.deschler@tufts.edu
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

​
source ~/.bashrc  # need to set up the normal environment.
echo running on: `hostname` # print some info about where we are running
cd $HOME
cd submission-analysis
conda activate coi-maps
​
python maps_and_lookups.py #$SLURM_ARRAY_TASK_ID # run the python code with the arguments. 
