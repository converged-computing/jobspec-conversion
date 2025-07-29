#!/bin/bash
#SBATCH --job-name=ORCA
#SBATCH --account=nesi99999
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=01:00:00

export P4_RSHCOMMAND='ssh'
export OMP_NUM_THREADS='1'

ml ORCA/3_0_2-linux_x86-64
export P4_RSHCOMMAND=ssh
export OMP_NUM_THREADS=1
cd $TMP_DIR
cp /share/test/benchmarks/Orca/XRQTC.Orca_B3LYP/input/* .
mv XRQTC.Orca_B3LYP.inp XRQTC.Orca_B3LYP.inp.1
echo "% pal nprocs $NSLOTS
    end" > XRQTC.Orca_B3LYP.inp.0  
cat XRQTC.Orca_B3LYP.inp.0 XRQTC.Orca_B3LYP.inp.1 > XRQTC.Orca_B3LYP.inp
rm XRQTC.Orca_B3LYP.inp.*
/share/easybuild/RHEL6.3/sandybridge/software/ORCA/3_0_2-linux_x86-64/orca XRQTC.Orca_B3LYP.inp > XRQTC.Orca_B3LYP.out
mkdir -p /share/test/benchmarks/Orca/XRQTC.Orca_B3LYP/OUT/orca
cp -r $TMP_DIR /share/test/benchmarks/Orca/XRQTC.Orca_B3LYP/OUT/orca/ 
TEMPS=$(cat XRQTC.Orca_B3LYP.out | grep Time: | awk '{print$3}')
echo "$NSLOTS   $TEMPS" >> /share/test/benchmarks/Orca/XRQTC.Orca_B3LYP/benchmark-ompi-XRQTC.Orca_B3LYP.dat
