#!/bin/bash
#SBATCH --job-name=seq-tiling
#SBATCH --output=seq-tiling.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:25:00
#SBATCH --partition=development

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.128   ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.256   ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.512   ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.1024  ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.2048  ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.4096  ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.8192  ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
./main ../../input/kron_g500-logn19/kron_g500-logn19.mtx.mesh.matlab.reordered.seq.tiling.16384 ../../input/kron_g500-logn19/kron_g500-logn19.mtx.xyz 
