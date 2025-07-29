#!/bin/bash
#SBATCH --account=nstaff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:00:00
#SBATCH --constraint=dgx

echo -e "\n\nBuilding and running Babelstream..."
./BabelStream_build_script.sh
echo -e "\n\nBuilding and running BerkeleyGW (GPP)..."
./BerkeleyGW_build_script.sh
echo -e "\n\nBuilding and running Kokkos incremental tests..."
./Kokkos_build_script.sh
echo -e "\n\nBuilding and running the Kokkos version of TestSNAP with both CUDA and OpenMPTarget backends..."
./TestSNAP_build_script.sh
echo -e "\n\nBuilding and running the native OpenMP version of TestSNAP..."
./TestSNAP_native_build_script.sh
