#!/bin/bash
#FLUX: --job-name=psycho-lamp-8919
#FLUX: -c=7
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export NMPI_PER_NODE='8'
export TOTAL_NMPI='$(( ${SLURM_JOB_NUM_NODES} * ${NMPI_PER_NODE} ))'

EXEC=Castro2d.hip.x86-trento.MPI.HIP.SMPLSDC.ex
INPUTS=inputs_2d.N14.coarse
module load PrgEnv-gnu craype-accel-amd-gfx90a cray-mpich rocm amd-mixed
function find_chk_file {
    # find_chk_file takes a single argument -- the wildcard pattern
    # for checkpoint files to look through
    chk=$1
    # find the latest 2 restart files.  This way if the latest didn't
    # complete we fall back to the previous one.
    temp_files=$(find . -maxdepth 1 -name "${chk}" -print | sort | tail -2)
    restartFile=""
    for f in ${temp_files}
    do
        # the Header is the last thing written -- check if it's there, otherwise,
        # fall back to the second-to-last check file written
        if [ ! -f ${f}/Header ]; then
            restartFile=""
        else
            restartFile="${f}"
        fi
    done
}
find_chk_file "*chk???????"
if [ "${restartFile}" = "" ]; then
    # look for 6-digit chk files
    find_chk_file "*chk??????"
fi
if [ "${restartFile}" = "" ]; then
    # look for 5-digit chk files
    find_chk_file "*chk?????"
fi
if [ "${restartFile}" = "" ]; then
    restartString=""
else
    restartString="amr.restart=${restartFile}"
fi
export OMP_NUM_THREADS=1
export NMPI_PER_NODE=8
export TOTAL_NMPI=$(( ${SLURM_JOB_NUM_NODES} * ${NMPI_PER_NODE} ))
srun -n${TOTAL_NMPI} -N${SLURM_JOB_NUM_NODES} --ntasks-per-node=8 --gpus-per-task=1 ./$EXEC $INPUTS ${restartString}
