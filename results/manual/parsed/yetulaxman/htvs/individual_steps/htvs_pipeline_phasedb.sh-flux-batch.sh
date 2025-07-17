#!/bin/bash
#FLUX: --job-name=hello-despacito-2190
#FLUX: -n=10
#FLUX: --queue=small
#FLUX: -t=4210
#FLUX: --urgency=16

module load maestro parallel
ls /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/*.maegz > test_phase_splice.list 
$SCHRODINGER/phase_database /scratch/project_2004075/yetukuri/Individual_jobs/LigPrep/data/test.phdb splice test_phase_splice.list  -new -fmt int -nosplit -JOB test_phase_splice -HOST localhost:10 -WAIT
