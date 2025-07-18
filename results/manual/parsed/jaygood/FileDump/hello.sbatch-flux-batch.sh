#!/bin/bash
#FLUX: --job-name=Get_Training_Data
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load pytorch/python3.6/0.2.0_3
source ../py3.6.3/bin/activate
pom_tf_battle --agents=test::agents.SimpleAgent,test::agents.SimpleAgent,test::agents.SimpleAgent,tensorforce::ppo --config=PommeTeamFast-v0 --render=''
