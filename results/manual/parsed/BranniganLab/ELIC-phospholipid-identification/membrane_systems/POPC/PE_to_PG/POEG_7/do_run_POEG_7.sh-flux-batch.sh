#!/bin/bash
#FLUX: --job-name=dinosaur-caramel-8167
#FLUX: --queue=cmain
#FLUX: --urgency=16

module purge
module load gcc mvapich2
NAMD=/projects/jdb252_1/tj227/bin/namd2-2.14-gcc-mvapich2
NEXT_DEPENDENCY=
FIRST=0
LAST=40
CHUNK_SIZE=6
JOB_NAME=POEG_7
PREFIX=POEG_7
for chunk_start in `seq $FIRST $CHUNK_SIZE $LAST`; do
chunk_end=$(($chunk_start + $CHUNK_SIZE - 1))
if (( $chunk_end > $LAST )); then
    chunk_end=$LAST
fi
SCRIPT() { cat <<RAR
module purge
module load gcc mvapich2
echo "PWD: \$PWD"
echo "Modules:"
module list
echo "SLURM_NTASKS: \$SLURM_NTASKS"
echo "Nodes: \$SLURM_JOB_NODELIST"
set -e 
THEN=\`date +%s\`
for m in \`seq $chunk_start $chunk_end\`; do
m=\`printf %03d \$m\`
namdconf=\$(python3 /home/tj227/mmdevel/relentless_fep.py config_${PREFIX}.yaml \${m})
if [ -z \$namdconf ]; then continue; fi
namdlog=\$(basename \$namdconf .namd).log
srun --mpi=pmi2 $NAMD \${namdconf} > \${namdlog}
NOW=\`date +%s\`
done
DURATION_MINS=\$(((\$NOW - \$THEN) / 60))
echo "${JOB_NAME}: Done with ${PREFIX} ${chunk_start}-${chunk_end} in $PWD (Wall clock: \$DURATION_MINS min)." | ~/bin/slack-ttjoseph
RAR
}
SCRIPT
JOBID=`SCRIPT | sbatch $NEXT_DEPENDENCY | tail -n1 | awk '{print $4}'`
echo "Submitted job using dependency argument: $NEXT_DEPENDENCY"
NEXT_DEPENDENCY="-d afterok:$JOBID"
NEXT_DEPENDENCY=
done
