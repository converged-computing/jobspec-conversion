#!/bin/bash
#SBATCH --job-name=extract_posterior_means
#SBATCH --mail-user=mrischard@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=01:00:00
#SBATCH --array=1-44

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
julia extract_posterior_means.jl \
    $ICAO \
    $GPmodel \
    /n/home04/mrischard/TempModel/data \
    /n/scratchlfs/pillai_lab/mrischard/saved \
    --hr_measure=17 \
    --crossval
