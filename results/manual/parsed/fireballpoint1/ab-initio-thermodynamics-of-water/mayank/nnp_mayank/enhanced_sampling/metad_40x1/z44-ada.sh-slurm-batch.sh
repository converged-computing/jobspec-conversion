#!/bin/bash
#SBATCH --account=research
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=3-00:00:00
#SBATCH --qos=medium

module load u18/openmpi/4.1.2
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_185_83_183_135_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_46_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_46_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_47_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_47_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_55_189_45_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_55_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_56_189_45_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_56_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_73_189_45_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_73_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_74_189_45_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_190_74_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_46_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_46_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_47_189_54_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_47_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_55_189_45_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_55_189_72_0-2_0-3_500_40000_index1.lmp
mpirun -np 15 /opt/n2p2/bin/lmp_mpi < nvt_share_H_heated_cooled_away_close_metad_191_56_189_45_0-2_0-3_500_40000_index1.lmp
