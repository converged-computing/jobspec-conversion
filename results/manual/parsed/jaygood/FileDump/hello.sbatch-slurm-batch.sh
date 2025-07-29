#!/bin/bash
#SBATCH --job-name=Get_Training_Data
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=1-00:00:00

module purge
module load pytorch/python3.6/0.2.0_3
source ../py3.6.3/bin/activate
pom_tf_battle --agents=test::agents.SimpleAgent,test::agents.SimpleAgent,test::agents.SimpleAgent,tensorforce::ppo --config=PommeTeamFast-v0 --render=''
