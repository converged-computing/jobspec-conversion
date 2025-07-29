#!/bin/bash
#SBATCH --job-name=DE_GSM
#SBATCH --output=std.output
#SBATCH --error=std.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=2-00:00:00
#SBATCH --partition=zimintel
#SBATCH --array=1

. /etc/profile.d/slurm.sh
module load qchem
module load pygsm
gsm  -coordinate_type DLC \
    -xyzfile ../../../data/diels_alder.xyz \
    -mode DE_GSM \
    -package QChem \
    -lot_inp_file qstart \
    -ID $SLURM_ARRAY_TASK_ID > log 2>&1
ID=`printf "%0*d\n" 3 $SLURM_ARRAY_TASK_ID`
rm -rf $QCSCRATCH/string_$ID
exit
