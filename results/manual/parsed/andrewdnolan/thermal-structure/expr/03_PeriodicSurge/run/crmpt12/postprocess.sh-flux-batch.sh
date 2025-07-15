#!/bin/bash
#FLUX: --job-name=dask_gridding
#FLUX: -c=32
#FLUX: -t=21600
#FLUX: --priority=16

export NUM_WORKERS='32'
export THREADS_PER_WORKER='1'

export NUM_WORKERS=32
export THREADS_PER_WORKER=1
source ../../config/modulefile.cc.cedar
source ./periodic_surge.sh
parse_params()
{   
  IFS=" " read -r QP beta NT T_0<<< $(echo $line | cut -d " " -f 7,9,11,13)
}
KEY='crmpt12'
create_dask_cluster
while IFS="" read -r line || [ -n "$line" ]; do
    # only parse the parameters that actually vary 
    parse_params $line
    # get the run name based on parsed parameters for the i-th run
    # NOTE: default value which aren't varied are hard coded
    run_name="${KEY}_dx_50_TT_${NT}.0_MB_-0.36_OFF_Tma_-8.5_B_${beta}_SP_2_QP_${QP}"
    # based on the start time (T_0) and time intergration length (NT)
    # caluculate the final time in kiloyears
    T_f=$(awk -v T_0=$T_0 -v NT=$NT 'BEGIN {print (T_0 + NT)/1e3}')
    # convert the start time from years to kiloyears
    T_0=$(awk -v T_0=$T_0 'BEGIN {print T_0/1e3}')
    # rename the file based on the restart point and integration length
    new_name="${KEY}_dx_50_TT_${T_0}--${T_f}ka_MB_-0.36_OFF_Tma_-8.5_B_${beta}_SP_2_QP_${QP}"
    # rename restart files
    mv "result/${KEY}/mesh_dx50/${run_name}.result"\
       "result/${KEY}/mesh_dx50/${new_name}.result"
    # rename the "raw" netcdf files
    mv "result/${KEY}/nc/${run_name}.nc"\
       "result/${KEY}/nc/${new_name}.nc"
    # overwrite the runname with the updated name,
    # we postprocess after renaming so the files packed into the zarr archieves have 
    # the correct filenames when unpacked
    run_name="${new_name}"
    # run the post processing commands
    post_proccess
done <run/${KEY}/${KEY}.commands
