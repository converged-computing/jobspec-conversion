#!/bin/bash
#SBATCH --account=research
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=3-00:00:00
#SBATCH --qos=medium

module load u18/openmpi/4.1.2
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_135_145_172_133_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_152_145_133_151_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_152_145_172_151_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_153_145_133_151_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_153_145_172_151_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_173_145_133_172_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_173_145_151_172_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_174_145_133_172_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_147_174_145_151_172_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_122_148_16_121_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_123_148_16_121_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_17_148_121_16_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_149_18_148_121_16_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_101_13_103_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_101_13_31_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_101_13_4_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_101_13_67_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_102_13_103_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_102_13_31_100_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_14_102_13_4_100_0-2_0-3_500_40000_index1.lmp
rm core*
