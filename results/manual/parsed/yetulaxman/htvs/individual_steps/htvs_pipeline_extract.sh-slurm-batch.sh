#!/bin/bash
#SBATCH --account=project_2004075
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=01:10:10
#SBATCH --partition=small

module load maestro 
$SCHRODINGER/phase_database /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/test.phdb extract test_extract -map -append -HOST localhost:10 -WAIT
