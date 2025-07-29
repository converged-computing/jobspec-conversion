#!/bin/bash
#SBATCH --job-name=quokka_benchmark
#SBATCH --account=pawsey0807-gpu
#SBATCH --output=1node_%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_OFI_NIC_POLICY='NUMA'

module load craype-accel-amd-gfx90a
module load rocm/5.2.3
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
EXE="build/src/HydroBlast3D/test_hydro3d_blast"
INPUTS="tests/benchmark_unigrid_512.in"
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
