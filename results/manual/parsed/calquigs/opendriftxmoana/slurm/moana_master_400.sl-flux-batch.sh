#!/bin/bash
#FLUX: --job-name=bigmomma_test
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
inPath='/nesi/nobackup/mocean02574/NZB_31/'
outPath='/nesi/nobackup/vuw03073/bigmomma/'
regions=('taranaki' 'waikato' '90milebeach' 'northland' 'hauraki' 'bay_o_plenty' 'east_cape' 'hawkes_bay' 'wairarapa' 'wellington' 'marlborough' 'kahurangi' 'west_coast' 'fiordland' 'southland' 'stewart_isl' 'otago' 'canterbury' 'kaikoura' 'chatham' 'auckland_isl')
months=(01 02 03 04 05 06 07 08 09 10 11 12)
years=(1994)
declare -a ym
for i in "${months[@]}"
do
    for j in "${years[@]}"
    do
         ym+=("$j""$i")
    done
done
num_runs_per_site=$((${#months[@]}*${#years[@]}))
region=${regions[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
lon=${lons[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
lat=${lats[$(($SLURM_ARRAY_TASK_ID/$num_runs_per_site))]}
echo $num_runs_per_site
echo $region
echo ${ym[$(($SLURM_ARRAY_TASK_ID%$num_runs_per_site))]}
python /nesi/project/vuw03073/opendriftxmoana/scripts/moana_master_400.py -i $inPath -o $outPath -r $region -ym ${ym[$(($SLURM_ARRAY_TASK_ID%$num_runs_per_site))]}
