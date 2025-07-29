#!/bin/bash
#SBATCH --job-name=hcl_mxmtask_queue_test
#SBATCH --output=./logs/hcl_mxmtask_queue_test_oneapi_%J.out
#SBATCH --error=./logs/hcl_mxmtask_queue_test_oneapi_%J.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:05:00
#SBATCH --partition=cm2_tiny
#SBATCH --qos=cm2_tiny
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --chdir=./

module load slurm_setup
module use ~/.modules
module use ~/local_libs/spack/share/spack/modules/linux-sles15-haswell
module load hwloc-2.4.1-oneapi-2021.1-rrkvihp
module load cmake-3.20.1-oneapi-2021.1-enbi76g
module load argobots-1.0-oneapi-2021.1-67jzgco
module load boost-1.76.0-oneapi-2021.1-z6jxqo3
module load cereal-1.3.0-oneapi-2021.1-h45mkqp
module load libfabric-1.11.1-oneapi-2021.1-ndxraku
module load mercury-2.0.0-oneapi-2021.1-gecxu7y
module load mochi-abt-io-0.5.1-oneapi-2021.1-byoahez
module load mochi-margo-0.9.1-oneapi-2021.1-fwjkhal
module load mochi-thallium-0.7-oneapi-2021.1-ln74gab
module load hcl-tl-oneapi-roce-1.0
echo "mpirun -n ${SLURM_NTASKS} ./main"
mpirun -n ${SLURM_NTASKS} ./main
