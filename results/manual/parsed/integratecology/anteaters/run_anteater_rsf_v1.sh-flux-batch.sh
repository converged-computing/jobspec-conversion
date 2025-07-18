#!/bin/bash
#FLUX: --job-name=ant_rsfs
#FLUX: --queue=defq
#FLUX: -t=345600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH'

module load gcc
export LD_LIBRARY_PATH="/home/alston92/software/gdal-3.3.0/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so
export LD_LIBRARY_PATH="/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so
module load R
cd /home/alston92/proj/anteaters   # where executable and data is located
list=(/home/alston92/proj/anteaters/data/*_r.csv)
date
echo "Initiating script"
if [ -f results/anteater_rsf_results_1.csv ]; then
	echo "Results file already exists! continuing..."
else
	echo "creating results file anteater_rsf_results.csv"
	echo "aid,pasture_est,pasture_lcl,pasture_ucl,nf_est,nf_lcl,nf_ucl,pf_est,pf_lcl,pf_ucl,stream_est,stream_lcl,stream_ucl,area,area_lcl,area_ucl,runtime" > results/anteater_rsf_results_1.csv
fi
Rscript anteater_rsfs_1.R ${list[SLURM_ARRAY_TASK_ID]}     # name of script
echo "Script complete"
date
