#!/bin/bash
#FLUX: --job-name="ICAR_tst"
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load python
conda activate myenv
export OMP_NUM_THREADS=1
PREFIX=tst  ##$SBATCH_JOB_NAME
OUTDIR=$PREFIX
OPTFILE=options.nml  #${PREFIX}_options.nml
BATCHFILE=batch_submit_SLURM.sh #${PREFIX}_batch_submit.sh
TEMPLATE=${PREFIX}_template.nml
EXE=$HOME/bin/icar_dbs
. /global/cfs/cdirs/m4062/env_scripts/UO-GNU-env.sh
SETUP_RUN=${HOME}/icar/helpers/setup_next_run.py
MAKE_TEMPLATE=${HOME}/icar/helpers/make_template.py
MKOUTDIR=mkdir #<user_defined_path>/mkscratch.py # mkscratch creates the directory on scratch and links to it
if [[ ! -e $TEMPLATE ]]; then
    $MAKE_TEMPLATE $OPTFILE $TEMPLATE > job_output/py_mktemp.out
fi
if [[ ! -e ${PREFIX}_finished ]]; then
    # first submit the next job dependant on this one
    # sub -w "ended(${PBS_JOBID})" < $BATCHFILE
    # qsub -W depend=afterany:${PBS_JOBID} ${BATCHFILE}  ## PBS version
    sbatch --dependency=afternotok:$SLURM_JOB_ID ${BATCHFILE}
    # if we have run before, setup the appropriate restart options
    if [[ -e ${PREFIX}_running ]]; then
        # echo "setting up next run (setup_next_run.py)"
        $SETUP_RUN $OPTFILE $TEMPLATE > job_output/py_setup.out
    fi
    # declare that we have run before so the next job will know
    touch ${PREFIX}_running
    # run the actual executable (e.g. icar options.nml)
    # cafrun -n 36 $EXE $OPTFILE > job_output/icar_$SLURM_JOB_ID.out
    cafrun -n 36 $EXE $OPTFILE >> job_output/icar.out ### if you prefer one log file for the icar output
    # typically the job will get killed while icar is running
    # but for some reason bkilling the job still lets it touch _finished...
    # maybe this will give it a chance to really kill it first?
    sleep 10
    # if icar completes, we are done, tell the next job that we finished
    # BK dont understand this: wont it prevent the next (or after-next job from starting (ln 63))
    touch ${PREFIX}_finished
else
    # if the last job ran to completion, delete the inter-job communication files and exit
    rm ${PREFIX}_running
    rm ${PREFIX}_finished
fi
