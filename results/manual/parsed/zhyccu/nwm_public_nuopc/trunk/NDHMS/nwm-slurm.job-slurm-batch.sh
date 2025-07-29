#!/bin/bash
#SBATCH --job-name=nwm-assim
#SBATCH --account=coastal
#SBATCH --error=slurm.error
#SBATCH --mail-user=beheen.m.trimble@noaa.gov
#SBATCH --mail-type=FAIL
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=07:00:00
#SBATCH --constraint=ntasks-per-node=24

                              # this deadline (start > (deadline - time[-min]))
                              # descriptor to export
                              # commands to.  Default is current cluster.
                              # Name of 'all' will submit to run on all clusters.
                              # NOTE: SlurmDBD must up.
                              # (type = block|cyclic|arbitrary)
                              # changes
                              # separated by semicolon, only on successful submission.
                              # value is all or none or any combination of
                              # energy, lustre, network or task
                              # Optimum switches and max time to wait for optimum
                              # smaller count
                              # per node
                              # cpu consumable resource is enabled
                              # cpu consumable resource is enabled
                              # and mcs plugin is enabled
                              # cpu required by the job.
                              # each field can be 'min' or wildcard '*'
                              # total cpus requested = (N x S x C x T)
                              # (see "--hint=help" for options)
                              # (see "--mem-bind=help" for options)
set -x
echo $SLURM_SUBMIT_DIR            # (in Slurm, jobs start in "current dir")       
echo $SLURM_JOBID                                                      
echo $SLURM_JOB_NAME
echo $SLURM_NNODES                                                     
echo $SLURM_TASKS_PER_NODE
echo $SLURM_NODELIST              # give you the list of assigned nodes.
echo "STARTING THE JOB AT"
date
srun ./nwm.exe
date
