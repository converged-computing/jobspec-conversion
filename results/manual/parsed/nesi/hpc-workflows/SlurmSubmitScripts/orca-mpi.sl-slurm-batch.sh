#!/bin/bash
#FLUX: --job-name=ORCA
#FLUX: -N=4
#FLUX: --queue=nonsusp
#FLUX: -t=199800
#FLUX: --urgency=16

export P4_RSHCOMMAND='ssh'
export OMP_NUM_THREADS='1'

ml ORCA/3_0_2-linux_x86-64
export P4_RSHCOMMAND=ssh
export OMP_NUM_THREADS=1
cd $SCRATCH_DIR
cp /share/test/Orca/NeSI_Muhammad_Hashmi/* .
mv XRQTC.Orca_localCCSD.inp XRQTC.Orca_localCCSD.inp.1
echo "% pal nprocs $SLURM_NTASKS
    end" > XRQTC.Orca_localCCSD.inp.0  
cat XRQTC.Orca_localCCSD.inp.0 XRQTC.Orca_localCCSD.inp.1 > XRQTC.Orca_localCCSD.inp
rm XRQTC.Orca_localCCSD.inp.*
/share/easybuild/RHEL6.3/sandybridge/software/ORCA/3_0_2-linux_x86-64/orca c60-c180.inp > c60-c180.out
mkdir -p /share/test/Orca/NeSI_Muhammad_Hashmi/out
cp -r $SCRATCH_DIR /share/test/Orca/NeSI_Muhammad_Hashmi/out
TEMPS=$(cat methane.out | grep "Time:" | awk '{print $3}')
echo "$SLURM_NTASKS   $TEMPS" >> /share/test/Orca/benchmark-NeSI_Muhammad_Hashmi.dat
