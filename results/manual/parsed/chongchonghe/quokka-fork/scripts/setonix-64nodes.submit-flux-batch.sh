#!/bin/bash
#FLUX: --job-name=faux-kitty-8433
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --priority=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_OFI_NIC_POLICY='NUMA'

module load craype-accel-amd-gfx90a
module load rocm/5.4.3
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
EXE="build/src/HydroBlast3D/test_hydro3d_blast"
INPUTS="tests/benchmark_unigrid_2048.in"
srun bash -c "
    case \$((SLURM_LOCALID)) in
      0) GPU=4;;
      1) GPU=5;;
      2) GPU=2;;
      3) GPU=3;;
      4) GPU=6;;
      5) GPU=7;;
      6) GPU=0;;
      7) GPU=1;;
    esac
    export ROCR_VISIBLE_DEVICES=\$((GPU));
    ${EXE} ${INPUTS}"
