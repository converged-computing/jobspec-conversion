#!/bin/bash
#FLUX: --job-name=analyse_occurence
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load StdEnv/2020 netcdf gcc/9.3.0 gdal/3.0.4
module load mpi4py proj
module load python/3.8
source /project/6070465/julemai/nrcan-hfe/env-3.8/bin/activate
cd /project/6070465/julemai/nrcan-hfe/src/
nfeatures=1949 #1854
ntasks=200         # make sure this is the number of tasks set for array-job
features=( $( seq $(( ${SLURM_ARRAY_TASK_ID} - 1 )) ${ntasks} $(( ${nfeatures} -1 )) ) )  # (2,12,22,...)
features=$( printf "%s," "${features[@]}" )   # "2,12,22,"
ifeatures=$( echo ${features::-1} )            # "2,12,22"
python analyse_occurrence.py -i "${ifeatures}" --bbox_buffer 0.5 --dates_buffer 5.0,0.0 --tmpdir "/project/6070465/julemai/nrcan-hfe/data/output/"
cd /project/6070465/julemai/nrcan-hfe/data/output/
ifeatures_list=$( tr -s ',' ' ' <<< "${ifeatures}" )    # "2 12 22"
for ifeature in ${ifeatures_list} ; do
    if [ -e "analyse_occurrence_${ifeature}.zip" ] ; then rm "analyse_occurrence_${ifeature}.zip" ; fi
    if [ -e "analyse_occurrence_${ifeature}" ] ; then zip -r "analyse_occurrence_${ifeature}.zip"  "analyse_occurrence_${ifeature}" ; fi
    rm -r "analyse_occurrence_${ifeature}"
done
cd -
