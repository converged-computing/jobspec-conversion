#!/bin/bash
#FLUX: --job-name=spicy-citrus-8513
#FLUX: --queue=long
#FLUX: -t=432000
#FLUX: --urgency=16

module load openmpi/4.0.1
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_125_78_124_187_76_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_176_124_187_175_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_176_124_76_175_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_177_124_187_175_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_177_124_76_175_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_188_124_175_187_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_188_124_76_187_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_189_124_175_187_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_189_124_76_187_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_77_124_175_76_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_77_124_187_76_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_78_124_175_76_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_126_78_124_187_76_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_158_127_169_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_158_127_190_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_158_127_55_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_158_127_73_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_159_127_169_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_159_127_190_157_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /global/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_128_159_127_55_157_0-2_0-3_500_40000_index1.lmp
rm core*
