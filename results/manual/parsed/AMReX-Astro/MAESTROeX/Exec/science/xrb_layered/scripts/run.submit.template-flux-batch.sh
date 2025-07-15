#!/bin/bash
#FLUX: --job-name=hairy-parrot-7316
#FLUX: -t=36000
#FLUX: --priority=16

XRB=$MAESTROEX_HOME/Exec/science/xrb_layered
MAESTRO_EXEC=$XRB/Maestro2d.gnu.x86-milan.MPI.ex
XRB_SCRATCH=$PSCRATCH/xrb_layered
INPUTS=inputs
RUN_DIR="RUN1"
cd $XRB_SCRATCH/$RUN_DIR
mkdir -p PLOTS
mkdir -p CHECKS
function find_chk_file {
    # find_chk_file takes a single argument -- the wildcard pattern
    # for checkpoint files to look through
    chk=$1
    # find the latest 2 restart files.  This way if the latest didn't
    # complete we fall back to the previous one.
    temp_files=$(find CHECKS -maxdepth 1 -name "${chk}" -print | sort | tail -2)
    restartFile=""
    for f in ${temp_files}
    do
        # the Header is the last thing written -- check if it's there, otherwise,
        # fall back to the second-to-last check file written
        if [ -f ${f}/Header ]; then
            restartFile="${f}"
        fi
    done
}
find_chk_file "*chk???????"
if [ "${restartFile}" = "" ]; then
    #restartString=""
    rm output.txt # we are starting over
    # In this case, we need to run the first step not in parallel
    ${MAESTRO_EXEC} ${INPUTS} maestro.max_step=1
    restartString="maestro.restart_file=CHECKS/chk0000001"
else
    restartString="maestro.restart_file=${restartFile}"
fi
echo $restartString
(sleep 595m && echo -e "\n    Nearing end of job, dumping checkfile now\n" && touch dump_and_continue)& 
srun -n $((SLURM_NNODES * SLURM_NTASKS_PER_NODE)) --cpu-bind=cores -c $((256 / SLURM_NTASKS_PER_NODE)) ${MAESTRO_EXEC} ${INPUTS} ${restartString} >> output.txt
