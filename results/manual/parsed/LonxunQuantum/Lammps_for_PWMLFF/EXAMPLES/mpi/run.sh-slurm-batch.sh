#!/bin/bash
#SBATCH --job-name=lmp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --nodelist=cn2

module load intel/2020
  exe_dir="/data/home/hfhuang/software/Lammps_for_PWMLFF-master/lammps_neigh_mlff_20230508/src"
  input="lammps.in"
  fid="test"
  echo "SLURM_NPROCS ${SLURM_NPROCS}" 
  mpirun -np ${SLURM_NPROCS} ${exe_dir}/lmp_mpi -in ${input} > ./data_out/out.${fid}
  #mpirun -np 1 ${exe_dir}/lmp_mpi -in ${input} > ./data_out/out.${fid}
