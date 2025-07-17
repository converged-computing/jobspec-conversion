#!/bin/bash
#FLUX: --job-name=all_settlement_test
#FLUX: -c=2
#FLUX: -t=14400
#FLUX: --urgency=16

export SLURM_EXPORT_ENV='ALL'
export HDF5_USE_FILE_LOCKING='FALSE'

export SLURM_EXPORT_ENV=ALL
export HDF5_USE_FILE_LOCKING=FALSE
module purge
module load Miniconda3
source activate opendrift_simon
inPath='/nesi/nobackup/mocean02574/NZB_3/'
outPath='/nesi/nobackup/vuw03073/bigboy/all_settlement/'
names=('FIO' 'BGB' 'HSB' 'TIM')
lons=(166.8 168.2 168.2 171.3)
lats=(-45.1 -46.9 -46.8 -44.4)
months=(08)
years=($(seq 1994 1996))
declare -a ym
for i in "${months[@]}"
do
    for j in "${years[@]}"
    do
         ym+=("$j""$i")
    done
done
num_runs_per_site=$((${#months[@]}*${#years[@]}))
name=${names[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
lon=${lons[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
lat=${lats[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
echo $num_runs_per_site
echo $name
echo ${ym[$(($SLURM_ARRAY_TASK_ID%$num_runs_per_site))]}
python /nesi/project/vuw03073/opendriftxmoana/scripts/moana_master.py -i $inPath -o $outPath -n $name -ym ${ym[$(($SLURM_ARRAY_TASK_ID%$num_runs_per_site))]} -lon $lon -lat $lat
