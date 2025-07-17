#!/bin/bash
#FLUX: --job-name=hanky-parsnip-1190
#FLUX: --queue=general-compute
#FLUX: -t=43200
#FLUX: --urgency=16

export HOME='$SLURMTMPDIR'
export TMP='$SLURMTMPDIR'

module load matlab
ulimit -s unlimited
export HOME=$SLURMTMPDIR
export TMP=$SLURMTMPDIR
echo -e "simString=${simString} \n"
echo -e "atomType=${atomType} \n"
echo -e "trialIndex=${trialIndex} \n"
echo -e "nBinsX=${nBinsX} \n"
echo -e "nBinsY=${nBinsY} \n"
echo -e "nWorkers=$SLURM_NTASKS \n"
echo -e "debug=${debug} \n"
echo -e 'matlab -nodisplay -r "spmd_chunk_wrapper(${simString}, ${atomType}, $SLURM_NTASKS, ${trialIndex}, ${nBinsX}, ${nBinsY}, ${debug})"'
matlab -nodisplay -r "spmd_chunk_wrapper('${simString}', '${atomType}', '$SLURM_NTASKS', '${trialIndex}', '${nBinsX}', '${nBinsY}', '${debug}')"
