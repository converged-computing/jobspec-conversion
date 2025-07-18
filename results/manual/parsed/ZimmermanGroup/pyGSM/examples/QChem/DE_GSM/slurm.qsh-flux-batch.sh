#!/bin/bash
#FLUX: --job-name=DE_GSM
#FLUX: -c=12
#FLUX: --queue=zimintel
#FLUX: -t=172800
#FLUX: --urgency=16

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
