#!/bin/bash
#SBATCH --job-name=pipeline_nearby
#SBATCH --mail-user=mrischard@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=12000
#SBATCH --time=02:00:00
#SBATCH --array=1,3,4,5,7,12,14,15,16,17,18,20,21,24,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,43,44

export JULIA_DEPOT_PATH='${HOME}/julia_depots/climate'

export JULIA_DEPOT_PATH="${HOME}/julia_depots/climate"
source ~/julia_modules.sh
test_ICAOs=(KABE KABQ KABR KATL KAUG KBDL KBHM KBIS KBNA KBWI KCAE KCEF KCMH
            KCOS KCRW KDLH KDSM KEUG KFAT KFYV KGTF KICT KIND KINW KJAN KJAX
            KLBF KLEX KLSE KMPV KMWL KOKC KPIH KPLN KPVD KRDU KROA KSEA KSGF
            KSHV KSLC KSPI KSYR KTPH)
ICAO=${test_ICAOs[$SLURM_ARRAY_TASK_ID-1]}
GPmodel=$1
cd /n/home04/mrischard/TempModel/batch/
echo "command line arguments"
echo "GPmodel" $GPmodel
echo "ICAO" $ICAO
julia pipeline1.jl $ICAO $GPmodel /n/home04/mrischard/TempModel/data /n/scratchlfs/pillai_lab/mrischard/saved --knearest=5
