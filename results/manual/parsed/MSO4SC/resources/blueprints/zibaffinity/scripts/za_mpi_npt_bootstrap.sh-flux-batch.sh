#!/bin/bash
#FLUX: --job-name=doopy-underoos-4436
#FLUX: --priority=16

ZA_SLURM="${4}/${6}"
za_tar=$(echo ${2} | sed 's#http://##g')
cat > $ZA_SLURM <<- EOM
cd $4
mpirun -np ${10} singularity exec -H \$HOME:/home/\$USER -B /mnt:/mnt,/scratch:/scratch $7 /bin/bash $8 $1 $za_tar $3 $4 $5 \$SCALE_INDEX ${10} ${11}
EOM
