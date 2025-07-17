#!/bin/bash
#FLUX: --job-name=pipeline_kernelfit
#FLUX: -n=2
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='${HOME}/julia_depots/climate'

export JULIA_DEPOT_PATH="${HOME}/julia_depots/climate"
source ~/julia_modules.sh
test_ICAOs=(KABE KABQ KABR KATL KAUG KBDL KBHM KBIS KBNA KBWI KCAE KCEF KCMH
            KCOS KCRW KDLH KDSM KEUG KFAT KFYV KGTF KICT KIND KINW KJAN KJAX
            KLBF KLEX KLSE KMPV KMWL KOKC KPIH KPLN KPVD KRDU KROA KSEA KSGF
            KSHV KSLC KSPI KSYR KTPH)
ICAO=${test_ICAOs[$SLURM_ARRAY_TASK_ID-1]}
cd /n/home04/mrischard/TempModel/batch/
echo "command line arguments"
echo "GPmodel" $1
echo "ICAO" $ICAO
julia pipeline0_kernelfit.jl \
	$ICAO \
	$1 \
	/n/home04/mrischard/TempModel/data \
	/n/scratchlfs/pillai_lab/mrischard/saved \
	--timelimit=79200 \
	--knearest=5
