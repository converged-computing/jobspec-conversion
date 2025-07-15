#!/bin/bash
#FLUX: --job-name=creamy-latke-5229
#FLUX: -N=4
#FLUX: -n=32
#FLUX: -t=1200
#FLUX: --priority=16

export PYTHONPATH='$PYTHONPATH:$ARL'
export OMP_NUM_THREADS='1'

. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load default-impi                   # REQUIRED - loads the basic environment
echo -e "Running python: `which python`"
. $HOME/arlenv/bin/activate
export PYTHONPATH=$PYTHONPATH:$ARL
echo "PYTHONPATH is ${PYTHONPATH}"
module load python
echo -e "Running python: `which python`"
echo -e "Running dask-scheduler: `which dask-scheduler`"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a hostfile:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > hostfile.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat hostfile.$JOBID | sed -e 's/\..*$//g'`
fi
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Master node: `hostname`"
echo "Current directory: `pwd`"
scheduler="`hostname`:8786"
echo "About to dask-ssh on:"
cat hostfile.$JOBID
dask-ssh --nprocs 8 --nthreads 1 --scheduler-port 8786 --log-directory `pwd` --hostfile hostfile.$JOBID &
sleep 60
scheduler="`hostname`:8786"
echo "Scheduler is running at ${scheduler}"
CMD="python ./losing_workers-loop.py ${scheduler}"
echo "About to execute $CMD"
eval $CMD
archive="output_${JOBID}"
echo "Moving results to ${archive}"
mkdir ${archive}
mv "slurm-${JOBID}".out ${archive}
mv hostfile.${JOBID} ${archive}
mv dask-ssh* ${archive}
cp *.py ${archive}
cp ${0}  ${archive}
