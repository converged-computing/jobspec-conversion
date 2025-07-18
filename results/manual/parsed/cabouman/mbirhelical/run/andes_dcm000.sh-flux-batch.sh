#!/bin/bash
#FLUX: --job-name=AAPM_000
#FLUX: -N=4
#FLUX: --queue=batch
#FLUX: -t=21600
#FLUX: --urgency=16

export NUM_NODES='$SLURM_JOB_NUM_NODES'
export NUM_FOCAL_SPOTS='1'
export NUM_SOURCES='1'
export OMP_NUM_THREADS='32'
export OMP_PROC_BIND='true   # new recommendations for hybrid MPI/OpenMP'
export OMP_PLACES='threads'
export DUAL_ENERGY='0'
export DEBUG_MODE='0'

module load gcc
export NUM_NODES=$SLURM_JOB_NUM_NODES
echo "$NUM_NODES"
export NUM_FOCAL_SPOTS=1
export NUM_SOURCES=1
export OMP_NUM_THREADS=32
export OMP_PROC_BIND=true   # new recommendations for hybrid MPI/OpenMP
export OMP_PLACES=threads
export DUAL_ENERGY=0
export DEBUG_MODE=0
weight_name="aapm-parameters/dcm_000"
echo "${weight_name}"
forward_model_directory="../data/${weight_name}/forward_model_directory.txt"
info_recon_directory="../data/${weight_name}/info_recon.txt"
prior_directory="../data/${weight_name}/prior_qggmrf.txt"
ce_directory="../data/${weight_name}/ce.txt"
recon_directory="/gpfs/alpine/proj-shared/gen006/muraligm/AAPM_2022/TrueCT/recons/dcm000/recon"
srun -N $NUM_NODES -n $NUM_NODES -c $OMP_NUM_THREADS --cpu_bind=cores ../src/ct ${forward_model_directory} ${NUM_FOCAL_SPOTS} ${info_recon_directory} ${prior_directory} ${ce_directory} ${recon_directory} 90 ${DUAL_ENERGY} ${DEBUG_MODE} ${NUM_SOURCES}
echo
echo " ============================ END DEMO ==========================="
