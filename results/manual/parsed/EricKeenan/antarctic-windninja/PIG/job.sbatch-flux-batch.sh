#!/bin/bash
#FLUX: --job-name=conspicuous-parrot-9787
#FLUX: --queue=shas
#FLUX: -t=14400
#FLUX: --urgency=16

base_dir=$(pwd)
meteo_dir="/scratch/summit/erke2265/LISTON_EXPLORE/output/grids/"
src_dem_path=/pl/active/nasa_smb/Data/IS2_cycle_1_2_3_DEM_noFilter.tif
module purge
ml intel; ml proj; ml gdal; ml singularity/3.6.4; ml gnu_parallel
SINGULARITY_LOCALCACHEDIR=${base_dir}/../../
SINGULARITY_CACHEDIR=${base_dir}/../../
SINGULARITY_TMPDIR=${base_dir}/../../
export SINGULARITY_LOCALCACHEDIR
export SINGULARITY_CACHEDIR
export SINGULARITY_TMPDIR
rm -rf processed_output
rm -rf 1980* # Note that this line will need to be updated for time steps not in 1980!
rm -f commands.txt
for FILE in ${meteo_dir}/*.vw
do
	ts=$(basename -s .vw $FILE)
	echo "bash run.sh ${ts} ${src_dem_path} ${meteo_dir} ${base_dir}" >> commands.txt
done
parallel --jobs ${SLURM_NTASKS} < commands.txt
