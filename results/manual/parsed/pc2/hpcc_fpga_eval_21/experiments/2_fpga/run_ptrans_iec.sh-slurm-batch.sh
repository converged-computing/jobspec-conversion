#!/bin/bash
#SBATCH --job-name=PTRANS
#SBATCH --output=ptrans_iec_N2_m64-%j.txt
#SBATCH --error=ptrans_iec_N2_m64-%j.txt
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=20.4.0_max

module load intel intelFPGA_pro/21.2.0 bittware_520n/20.4.0_max devel/CMake/3.15.3-GCCcore-8.3.0
srun ../../synthesis_artifacts/PTRANS/520n-21.2.0-20.4.0-iec/Transpose_intel \
    -f ../../synthesis_artifacts/PTRANS/520n-21.2.0-20.4.0-iec/transpose_PQ_IEC.aocx \
    -n 10 -m 128 -b 512 -r 4
