#!/bin/bash
#FLUX: --job-name=dask_gridding
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --priority=16

export NUM_WORKERS='16'
export THREADS_PER_WORKER='1'

CHUNK_SIZE=48
export NUM_WORKERS=16
export THREADS_PER_WORKER=1
source ../../config/modulefile.cc.cedar
parse_params()
{
  IFS=" " read -r offset T_ma \
    <<< $(sed -n "${1}p" ./run/crmpt12/gridsearch.commands | cut -d " " -f 13,15)
}
create_dask_cluster()
{
  export SCHEDULER_FILE="${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}-scheduler.json"
  dask scheduler --host 127.0.0.1 --no-dashboard --scheduler-file $SCHEDULER_FILE &
  sleep 15
  for worker in $(seq $NUM_WORKERS); do
  dask worker --scheduler-file $SCHEDULER_FILE \
              --no-dashboard \
              --no-nanny \
              --nworkers 1 \
              --nthreads 1 &
  done
  sleep 15
}
post_proccess()
{
  # get the j-th air temp and mass balance values
  parse_params $1
  # from the parameters fill out the run_name
  run_name="crmpt12_dx_50_NT_30000_dt_0.1_MB_${offset}_OFF_Tma_${T_ma}_prog"
  # create parameter json (dictionary) for gridding Zarr files
  param_dict="{\"T_ma\"   : ${T_ma},
              \"offset\" : ${offset}}"
  # copy the source file from scratch to local (compute node's) SSD
  time rsync -ah "result/crmpt12/nc/${run_name}.nc" "${SLURM_TMPDIR}"
  # grid the NetCDF file written by the NetcdfUGRIDOutputSolver, 
  # convert from NetCDF to Zarr file format
  time grid_data.py -i "${SLURM_TMPDIR}/${run_name}.nc" \
                    -o "${SLURM_TMPDIR}/${run_name}.zarr" \
                    -p "${param_dict}"
  # run the subsampling script, write a years worth of data every 10 years
  time downsample.py -i "${SLURM_TMPDIR}/${run_name}.zarr" \
                     -o  "${SLURM_TMPDIR}/thinned/${run_name}.zarr" \
                     --value --years_worth 10
  # tar the full zarr file, and write the tar to scratch
  time tar -cf "result/crmpt12/gridded/${run_name}.zarr.tar" -C "${SLURM_TMPDIR}" "${run_name}.zarr"
  # tar the thinned zarr file, and write the tar to scratch
  time tar -cf "result/crmpt12/thinned/${run_name}.zarr.tar" -C "${SLURM_TMPDIR}/thinned" "${run_name}.zarr"
  # delete files from SSD to make room for next files
  rm "${SLURM_TMPDIR}/${run_name}.nc"
  rm -r "${SLURM_TMPDIR}/${run_name}.zarr"
  rm -r "${SLURM_TMPDIR}/thinned/${run_name}.zarr"
}
mkdir "${SLURM_TMPDIR}/thinned"
if [ ! -d "result/crmpt12/thinned/" ]; then
  mkdir  "result/crmpt12/thinned/"
fi
create_dask_cluster
start=$((SLURM_ARRAY_TASK_ID * CHUNK_SIZE))
stop=$((start + CHUNK_SIZE))
for j in $(seq $start $stop); do 
  # add one to j since sed is indexed at 1
  j=$((j + 1))
  # only ran 286 runs, so make sure we don't go over 
  if [[ $j -le 286 ]]; then 
    # run the post processing commands
    post_proccess $j
  fi
done 
