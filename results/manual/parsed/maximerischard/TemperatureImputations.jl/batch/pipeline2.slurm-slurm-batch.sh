#!/bin/bash
#SBATCH --job-name=stan_pipeline2
#SBATCH --mail-user=mrischard@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5000
#SBATCH --time=12:00:00
#SBATCH --partition=shared
#SBATCH --array=1-90

export JULIA_DEPOT_PATH='${HOME}/julia_depots/climate'

            #KCOS KCRW KDLH KDSM KEUG KFAT KFYV KGTF KICT KIND KINW KJAN KJAX
            #KLBF KLEX KLSE KMPV KMWL KOKC KPIH KPLN KPVD KRDU KROA KSEA KSGF
            #KSHV KSLC KSPI KSYR KTPH)
export JULIA_DEPOT_PATH="${HOME}/julia_depots/climate"
source ~/julia_modules.sh
echo "command line arguments"
GPmodel=$1
echo "GPmodel" $GPmodel
ICAO=$2
echo ICAO $ICAO
cd /n/home04/mrischard/TempModel/batch/
ksmoothmax=50
epsilon=0.01
julia pipeline2.jl \
    $ICAO \
    $GPmodel \
    ${SLURM_ARRAY_TASK_ID} \
    /n/home04/mrischard/TempModel/data \
    /n/scratchlfs/pillai_lab/mrischard/saved \
    --seed=${SLURM_ARRAY_TASK_ID} \
    --ksmoothmax=$ksmoothmax \
    --epsilon=$epsilon \
    --crossval
