#!/bin/bash
#SBATCH --job-name=S13M3
#SBATCH --output=./output-blue/output_%j.out
#SBATCH --error=./output-blue/error_%j.err
#SBATCH --mail-user=j.rose@ufl.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6000mb
#SBATCH --time=4-00:00:00
#SBATCH --qos=paul.torrey-b
#SBATCH --constraint=ntasks-per-socket=8

export OMPI_MCA_pml='ucx'
export OMPI_MCA_btl='^vader,tcp,openib'
export OMPI_MCA_oob_tcp_listen_mode='listen_thread'

module purge
module load intel/2018.1.163
module load openmpi/3.1.2
module load gsl/2.4
module load fftw/3.3.7
module list
export OMPI_MCA_pml="ucx"
export OMPI_MCA_btl="^vader,tcp,openib"
export OMPI_MCA_oob_tcp_listen_mode="listen_thread"
sbatch runit.slurm
srun --mpi=pmix_v2 ./Arepo-newtol param.txt 1
