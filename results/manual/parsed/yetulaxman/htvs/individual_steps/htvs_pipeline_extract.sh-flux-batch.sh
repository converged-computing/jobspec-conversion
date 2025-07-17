#!/bin/bash
#FLUX: --job-name=purple-staircase-2914
#FLUX: -n=10
#FLUX: --queue=small
#FLUX: -t=4210
#FLUX: --urgency=16

module load maestro 
$SCHRODINGER/phase_database /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/test.phdb extract test_extract -map -append -HOST localhost:10 -WAIT
