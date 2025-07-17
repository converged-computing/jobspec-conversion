#!/bin/bash
#FLUX: --job-name=fugly-platanos-2494
#FLUX: -N=16
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export KMP_AFFINITY='disabled'

NP=$(($SLURM_JOB_NUM_NODES * $SLURM_NTASKS_PER_NODE))
echo "------------------------------------------------------"
echo "---- SLURM_CLUSTER_NAME    = $SLURM_CLUSTER_NAME"
echo "---- SLURM_JOB_QOS         = $SLURM_JOB_QOS"
echo "---- SLURM_JOB_PARTITION   = $SLURM_JOB_PARTITION"
echo "---- SBATCH_CONSTRAINT     = $SBATCH_CONSTRAINT"
echo "---- SLURM_JOB_NUM_NODES   = $SLURM_JOB_NUM_NODES"
echo "---- SLURM_NTASKS_PER_NODE = $SLURM_NTASKS_PER_NODE"
echo "---- No. MPI processes     = $NP"
echo "------------------------------------------------------"
echo ""
export OMP_NUM_THREADS=1
export KMP_AFFINITY=disabled
IN_DIR=/scratch/uboone_in
IN_FILE=uboone_numu_slice_seq.h5
IN_ARG=$IN_DIR/$IN_FILE
OUT_DIR=/scratch/uboone_out
OUT_PREFIX=uboone_numu_slice_panoptic_graphs
OUT_ARG=$OUT_DIR/$OUT_PREFIX
srun -n $NP $EXE_OPTS shifter python3 example/process.py -i $IN_ARG -o $OUT_ARG -p -5 -f
