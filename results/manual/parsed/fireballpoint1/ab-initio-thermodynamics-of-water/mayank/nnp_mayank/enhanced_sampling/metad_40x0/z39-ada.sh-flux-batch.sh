#!/bin/bash
#FLUX: --job-name=creamy-truffle-5788
#FLUX: -t=259200
#FLUX: --urgency=16

module load u18/openmpi/4.1.2
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_156_74_154_4_73_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_156_74_154_70_73_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_156_75_154_118_73_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_156_75_154_4_73_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_156_75_154_70_73_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_119_157_127_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_119_157_43_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_120_157_127_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_120_157_43_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_128_157_118_127_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_128_157_43_127_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_129_157_118_127_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_129_157_43_127_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_44_157_118_43_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_44_157_127_43_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_45_157_118_43_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_158_45_157_127_43_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_159_119_157_127_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_159_119_157_43_118_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_159_120_157_127_118_0-2_0-3_500_40000_index1.lmp
rm core*
