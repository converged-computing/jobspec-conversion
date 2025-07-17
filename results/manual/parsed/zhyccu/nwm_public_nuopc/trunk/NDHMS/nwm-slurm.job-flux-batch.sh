#!/bin/bash
#FLUX: --job-name=nwm-assim
#FLUX: -N=32
#FLUX: -t=25200
#FLUX: --urgency=16

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
