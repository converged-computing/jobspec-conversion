#!/bin/bash
#FLUX: --job-name=tapir_cv
#FLUX: --queue=defq,intel
#FLUX: -t=14400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH'

module load gcc
export LD_LIBRARY_PATH="/home/alston92/software/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/alston92/software/gdal-3.3.0/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/alston92/software/proj-8.0.1/lib:$LD_LIBRARY_PATH"
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/terra/libs/terra.so
ldd /home/alston92/R/x86_64-pc-linux-gnu-library/3.6/rgdal/libs/rgdal.so
module load R
cd /home/alston92/proj/rsf_akdes  # where executable and data is located
list=(/home/alston92/proj/rsf_akdes/data/ce_*_r.csv)
date
echo "Initiating script"
if [ -f results/cv_summary_ce_tapir.csv ]; then
	echo "Results file already exists! continuing..."
else
	echo "creating results file"
	echo "id, ind_file, ess, cv_ll_ud, cv_ll_rsf, ud10_area, ud20_area, ud30_area, ud40_area, ud50_area, ud60_area, ud70_area, ud80_area, ud90_area, ud99_area, ud10_rsf_area, ud20_rsf_area, ud30_rsf_area, ud40_rsf_area, ud50_rsf_area, ud60_rsf_area, ud70_rsf_area, ud80_rsf_area, ud90_rsf_area, ud99_rsf_area, pct10, pct20, pct30, pct40, pct50, pct60, pct70, pct80, pct90, pct99, pct10_rsf, pct20_rsf, pct30_rsf, pct40_rsf, pct50_rsf, pct60_rsf, pct70_rsf, pct80_rsf, pct90_rsf, pct99_rsf" > results/cv_summary_ce_tapir.csv
fi
Rscript cv_ce_tapir.R ${list[SLURM_ARRAY_TASK_ID]}     # name of script
echo "Script complete"
date
