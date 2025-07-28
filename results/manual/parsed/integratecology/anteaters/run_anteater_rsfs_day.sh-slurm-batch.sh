#!/bin/bash
#FLUX: --job-name=ant_rsfs
#FLUX: --queue=defq
#FLUX: -t=345600
#FLUX: --urgency=16

ml gcc/10.2.0 R/4.3.0  sqlite/3.42.0  gdal/3.7.0  gcc/10.2.0 openblas/skylake/0.3.17  zlib/1.2.11  openmpi/4.1.1  hdf5-parallel/1.12.0-omp411   cmake/3.26.1  libtiff/4.0.9  curl/7.85.0  python/3.10.4  xerces/3.1.4 libarchiv/3.6.2  proj/9.2.1 gsl/2.5
cd /home/alston92/proj/anteaters   # where executable and data is located
list=(/home/alston92/proj/anteaters/data/*_r.csv)
date
echo "Initiating script"
if [ -f results/anteater_rsf_results_day.csv ]; then
	echo "Results file already exists! continuing..."
else
	echo "creating results file"
	echo "aid,nf_est,nf_lcl,nf_ucl,pf_est,pf_lcl,pf_ucl,nf_temp_est,nf_temp_lcl,nf_temp_ucl,pf_temp_est,pf_temp_lcl,pf_temp_ucl" > results/anteater_rsf_results_day.csv
fi
Rscript anteater_rsfs_day.R ${list[SLURM_ARRAY_TASK_ID]}     # name of script
echo "Script complete" date
