#!/bin/bash
#SBATCH --account=research
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=5-00:00:00
#SBATCH --qos=medium

module load openmpi/4.0.1
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index60.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index61.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index62.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index63.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index64.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index65.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index66.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index67.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index68.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_close_close_14_104_13__0-1_5000_0-1_5000_400_2000_index69.lmp
