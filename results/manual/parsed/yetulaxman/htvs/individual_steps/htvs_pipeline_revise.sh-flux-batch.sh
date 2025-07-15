#!/bin/bash
#FLUX: --job-name=dinosaur-truffle-9699
#FLUX: -n=10
#FLUX: --queue=small
#FLUX: -t=4210
#FLUX: --urgency=16

module load maestro 
$SCHRODINGER/phase_database /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/test.phdb revise test_revise -confs auto -max 1 -bf 10 -amide trans -ewin 25.0 -sample rapid -HOST localhost:10 -WAIT
