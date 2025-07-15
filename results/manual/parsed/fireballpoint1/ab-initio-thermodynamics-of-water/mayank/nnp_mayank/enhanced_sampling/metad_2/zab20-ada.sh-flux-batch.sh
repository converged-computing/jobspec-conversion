#!/bin/bash
#FLUX: --job-name=confused-cat-4361
#FLUX: --queue=long
#FLUX: -t=432000
#FLUX: --priority=16

module load openmpi/4.0.1
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_74_189__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_103_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_104_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_112_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_113_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_136_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_137_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_34_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_35_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_85_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_1_86_0__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_22_112_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_22_113_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_22_181_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_22_182_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_23_112_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_23_113_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_23_181_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_23_182_21__0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_25_88_24__0-2_0-3_500_40000_index1.lmp
rm bck.*.HILLS
