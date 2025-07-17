#!/bin/bash
#FLUX: --job-name=graphcast
#FLUX: -c=30
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --urgency=16

module use /contrib/spack-stack/envs/ufswm/install/modulefiles/Core/
module load stack-intel
module load wgrib2
module list
current_hour=$(date -u +%H)
current_hour=$((10#$current_hour))
if (( $current_hour >= 0 && $current_hour < 6 )); then
    datetime=$(date -u -d 'today 00:00')
elif (( $current_hour >= 6 && $current_hour < 12 )); then
    datetime=$(date -u -d 'today 06:00')
elif (( $current_hour >= 12 && $current_hour < 18 )); then
    datetime=$(date -u -d 'today 12:00')
else
    datetime=$(date -u -d 'today 18:00')
fi
curr_datetime=$( date -d "$datetime 12 hour ago" "+%Y%m%d%H" )
prev_datetime=$( date -d "$datetime 18 hour ago" "+%Y%m%d%H" )
echo "Current state: $curr_datetime"
echo "6 hours earlier state: $prev_datetime"
forecast_length=40
echo "forecast length: $forecast_length"
num_pressure_levels=37
echo "number of pressure levels: $num_pressure_levels"
source /contrib/Sadegh.Tabas/miniconda3/etc/profile.d/conda.sh
conda activate mlwp
cd /contrib/Sadegh.Tabas/operational/graphcast/NCEP/
start_time=$(date +%s)
echo "start runing gdas utility to generate graphcast inputs for: $curr_datetime"
python3 gdas_utility.py "$prev_datetime" "$curr_datetime" -l "$num_pressure_levels"
end_time=$(date +%s)  # Record the end time in seconds since the epoch
execution_time=$((end_time - start_time))
echo "Execution time for gdas_utility.py: $execution_time seconds"
start_time=$(date +%s)
echo "start runing graphcast to get real time 10-days forecasts for: $curr_datetime"
python3 run_graphcast.py -i source-gdas_date-"$curr_datetime"_res-0.25_levels-"$num_pressure_levels"_steps-2.nc -w /contrib/graphcast/NCEP -l "$forecast_length" -p "$num_pressure_levels" -u yes -k no
end_time=$(date +%s)  # Record the end time in seconds since the epoch
execution_time=$((end_time - start_time))
echo "Execution time for graphcast: $execution_time seconds"
