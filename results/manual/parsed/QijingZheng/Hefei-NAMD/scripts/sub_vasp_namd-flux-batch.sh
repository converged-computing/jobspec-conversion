#!/bin/bash
#FLUX: --job-name=gloopy-poo-7988
#FLUX: --queue=h3c
#FLUX: -t=43200
#FLUX: --urgency=16

ulimit -s unlimited
module load vasp/6.1.0
echo "============================================================"
module list
env | grep "MKLROOT="
echo "============================================================"
echo "Job ID: $SLURM_JOB_NAME"
echo "Job name: $SLURM_JOB_NAME"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Number of processors: $SLURM_NTASKS"
echo "Task is running on the following nodes:"
echo $SLURM_JOB_NODELIST
echo "OMP_NUM_THREADS = $SLURM_CPUS_PER_TASK"
echo "============================================================"
echo
START=1
END=2000
NDIGIT=$(echo -n ${END} | wc -c)
RUNDIR=${PWD}
PREFIX="run"
for i in `seq ${START} ${END}`
do
    (( j = i - 8 ))
    ii=`printf "%0${NDIGIT}d" ${i}`
    jj=`printf "%0${NDIGIT}d" ${j}`
    if [[ -d "${PREFIX}/${ii}" ]]; then
        # goto the working directory
        cd ${PREFIX}/${ii}
        # Skip this directory if job is running or has ended
        if [[ -f RUNNING || -f ENDED ]]; then
            # Do nothing, go back to the parent directory
            cd ${RUNDIR}
            continue
        fi
        # Mark the directory as RUNNING
        touch RUNNING
        echo "#### RUNNING in DIR: ${RUNDIR}/${PREFIX}/${ii}"
        sleep 1
        # Copy the CHGCAR from the nearest finished job to accelerate current job
        [[ -s ../${jj}/CHGCAR && -f ../${jj}/ENDED ]] && cp ../${jj}/CHGCAR .
        ############################################################
        # Run VASP
        ############################################################
        # srun vasp_std
        srun vasp_gam
        # srun vasp_ncl
        ############################################################
        # Check if jobs ended correctly
        if grep 'Total CPU' OUTCAR >& /dev/null; then
            # If so, mark the job as ENDED
            touch ENDED
        else
            rm ENDED 2> /dev/null
        fi
        # Delete redundant files
        rm RUNNING CHG vasprun.xml >& /dev/null
        # Go back to the parent directory
        cd ${RUNDIR}
    fi
done
