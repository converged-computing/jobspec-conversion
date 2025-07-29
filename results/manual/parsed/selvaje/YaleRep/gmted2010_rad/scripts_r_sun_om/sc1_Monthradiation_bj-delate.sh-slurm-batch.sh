#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/selvaje/YaleRep/gmted2010_rad/scripts_r_sun_om/sc1_Monthradiation_bj-delate.sh
