#!/bin/bash
#FLUX: --job-name=ant_rsfs
#FLUX: --queue=defq
#FLUX: -t=43200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH'

module load gcc
export LD_LIBRARY_PATH="/home/alston92/software/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/alston92/software/gdal-3.3.0/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/terra/libs/terra.so
ldd /home/alston91/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so
module load R
cd /home/alston92/proj/anteaters   # where executable and data is located
list=(/home/alston92/proj/anteaters/data/*_r.csv)
date
echo "Initiating script"
if [ -f results/anteater_rsf_results_2_v2.csv ]; then
	echo "Results file already exists! continuing..."
else
	echo "creating results file anteater_rsf_results_2.csv"
	echo ""id,stream_est,stream_lcl,stream_ucl,roads_est,roads_lcl,roads_ucl,stream_temp_est,stream_temp_lcl,stream_temp_ucl,roads_temp_est,roads_temp_lcl,roads_temp_ucl,area,area_lcl,area_ucl,runtime > results/anteater_rsf_results_2_v2.csv
fi
Rscript anteater_rsfs_2.R ${list[SLURM_ARRAY_TASK_ID]}     # name of script
echo "Script complete" date
