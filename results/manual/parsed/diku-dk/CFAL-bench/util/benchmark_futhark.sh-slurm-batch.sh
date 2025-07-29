#!/bin/bash
#SBATCH --job-name=cfal-futhark
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:nvidia_a30:1
#SBATCH --mem=64G
#SBATCH --time=00:30:00
#SBATCH --partition=csmpi_fpga_long

export PATH='/vol/itt/data/cfal/team-futhark/bin/:$PATH'

set -e
export PATH=/vol/itt/data/cfal/team-futhark/bin/:$PATH
time2flops="util/futhark-time2flops.py"
make -C MG/futhark run_multicore
make -C MG/futhark run_cuda
echo MG CPU GFLOP/s
$time2flops MG/futhark/mg_multicore.json mg.fut:mgNAS 'Class A' 3.625 'Class B' 18.125  'Class C' 145.0
echo MG GPU GFLOP/s
$time2flops MG/futhark/mg_cuda.json mg.fut:mgNAS 'Class A' 3.625  'Class B' 18.125 'Class C' 145.0
make -C LocVolCalib/futhark run_ispc
make -C LocVolCalib/futhark run_cuda
make -C quickhull/futhark run_multicore
make -C quickhull/futhark run_cuda
make -C nbody-naive/futhark run_multicore
make -C nbody-naive/futhark run_cuda
echo "N-body CPU (all threads) GFLOP/s"
$time2flops nbody-naive/futhark/nbody_multicore.json nbody.fut 'n=1000' 1800 'n=10000' 1800 'n=100000' 1800
echo "N-body GPU GFLOP/s"
$time2flops nbody-naive/futhark/nbody_cuda.json nbody.fut 'n=1000' 1800 'n=10000' 1800 'n=100000' 1800
