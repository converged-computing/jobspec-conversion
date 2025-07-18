#!/bin/bash
#FLUX: --job-name=CA-CP
#FLUX: -N=125
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export CRAYPE_LINK_TYPE='dynamic'
export MPIR_CVAR_GPU_EAGER_DEVICE_MEM='0'
export MPICH_GPU_SUPPORT_ENABLED='1'

export OMP_NUM_THREADS=1
cd $SLURM_SUBMIT_DIR
baseDir="$PWD"
module reset
module load craype-accel-amd-gfx90a
module load rocm/5.4.0
export CRAYPE_LINK_TYPE=dynamic
export MPIR_CVAR_GPU_EAGER_DEVICE_MEM=0
export MPICH_GPU_SUPPORT_ENABLED=1
PATH_exaca="/lustre/orion/mat190/world-shared/rolchigo/ExaCA"
EXE_exaca="$PATH_exaca/build_amd_cp/install/bin/ExaCA-Kokkos"
EXE_exaca_analysis="$PATH_exaca/build_amd_cp/install/bin/grain_analysis"
FLAGS_exaca="--gpus-per-task=1 --cpus-per-task=1 --gpu-bind=closest --exclusive"
SRUN_exaca="srun -N 1 -n 8 -c 7 -m *:fcyclic $FLAGS_exaca $EXE_exaca"
SRUN_exaca_analysis="srun -N 1 -n 1 -m *:fcyclic --exclusive --cpus-per-task=1 $EXE_exaca_analysis"
for d in $baseDir/cases/exaca/*
do
    (
        cd $d
        $SRUN_exaca inputs.json > log.exaca 2>&1
    ) &
    sleep 0.1
done
wait
for d in $baseDir/cases/exaca/*
do
    (
        cd $d
	    caseid="${d##*/}"
        $SRUN_exaca_analysis $baseDir/templates/exaca/AnalyzeAMB.json $d/$caseid > log.exaca 2>&1
    ) &
    sleep 0.1
done
wait
