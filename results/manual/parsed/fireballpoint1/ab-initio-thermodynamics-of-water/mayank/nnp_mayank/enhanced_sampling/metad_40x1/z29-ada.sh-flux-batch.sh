#!/bin/bash
#FLUX: --job-name=adorable-gato-5417
#FLUX: -t=259200
#FLUX: --priority=16

module load u18/openmpi/4.1.2
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_148_88_147_150_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_148_88_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_148_89_147_12_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_148_89_147_150_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_148_89_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_13_147_150_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_13_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_13_147_87_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_14_147_150_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_14_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_14_147_87_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_151_147_12_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_151_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_151_147_87_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_152_147_12_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_152_147_162_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_152_147_87_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_163_147_12_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_163_147_150_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_163_147_87_0-2_0-3_500_40000_index1.lmp
