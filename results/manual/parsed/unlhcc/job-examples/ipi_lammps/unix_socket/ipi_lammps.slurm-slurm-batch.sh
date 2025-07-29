#!/bin/bash
#SBATCH --job-name=ipi_lammps_example
#SBATCH --output=ipi_lammps_job.%J.out
#SBATCH --error=ipi_lammps_job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=20

export PYTHONUNBUFFERED='1'
export PSM2_CUDA='0'

module purge
module load compiler/gcc/11 openmpi/4.1 lammps/23June2022
export PYTHONUNBUFFERED=1
export PSM2_CUDA=0
HOST=$(hostname)
sed -i "s/address>[^<]*</address>$HOST</" input.xml
i-pi input.xml &> log.ipi &
sleep 20
sed -i "s/localhost/$HOST/" in.lmp
mpirun `which lmp` < in.lmp > lammps.out
