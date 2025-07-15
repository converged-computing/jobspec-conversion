#!/bin/bash
#FLUX: --job-name=spicy-lemon-4312
#FLUX: --queue=long
#FLUX: -t=432000
#FLUX: --priority=16

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
