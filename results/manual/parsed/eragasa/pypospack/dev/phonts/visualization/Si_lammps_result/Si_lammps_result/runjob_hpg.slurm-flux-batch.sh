#!/bin/bash
#FLUX: --job-name=Si_phonts_LAMMPS_P
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --priority=16

echo slurm_job_id:$SLURM_JOB_ID
echo slurm_job_name:$SLURM_JOB_NAME
echo slurm_job_nodelist:$SLURM_JOB_NODELIST
echo slurm_job_num_nodes:$SLURM_JOB_NUM_NODES
echo slurm_cpus_on_node:$SLURM_CPUS_ON_NODE
echo slurm_ntasks:$SLURM_NTASKS
echo working directory:$(pwd)
echo hostname:$(hostname)
echo start_time:$(date)
module load intel/2016.0.109
module load openmpi/1.10.2
srun --mpi=pmi2 PhonTS > phonts.std.out
touch jobCompleted
echo end_time:$(date)
