#!/bin/bash
#FLUX: --job-name=chwm-sampler
#FLUX: --queue=debug
#FLUX: --urgency=16

export LAMMPS_BIN='/global/homes/e/ejragasa/edison_bin/lmp_serial'
export PYTHONPATH='$PYFLAMESTK_DIR:$PYTHONPATH'

module load python/3.4
export LAMMPS_BIN=/global/homes/e/ejragasa/edison_bin/lmp_serial
PYFLAMESTK_DIR=~/repos/sdav-chwm-pareto/pyflamestk
export PYTHONPATH=$PYFLAMESTK_DIR:$PYTHONPATH
echo "slurm_jobid: $SLURM_JOBID"
echo "slurm_submit_dir: $SLURM_SUBMIT_DIR"
echo "slurm_job_nodelist: $SLURM_JOB_NODELIST"
echo "slurm_job_num_nodes: $SLURM_JOB_NUM_NODES"
echo "Starting computation"
N_CORES_PER_NODE=24
N_CORES=$(($N_CORES_PER_NODE*$SLURM_JOB_NUM_NODES))
srun -u -n $N_CORES python3 call_LAMMPS_concurrently.py
