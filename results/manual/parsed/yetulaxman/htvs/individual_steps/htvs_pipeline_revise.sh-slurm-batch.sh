#!/bin/bash
#SBATCH --account=project_2004075
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=01:10:10

module load maestro 
$SCHRODINGER/phase_database /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/test.phdb revise test_revise -confs auto -max 1 -bf 10 -amide trans -ewin 25.0 -sample rapid -HOST localhost:10 -WAIT
