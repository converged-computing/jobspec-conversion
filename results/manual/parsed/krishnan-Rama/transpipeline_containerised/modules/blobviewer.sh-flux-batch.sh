#!/bin/bash
#FLUX: --job-name=pipeline
#FLUX: -c=2
#FLUX: --queue=epyc
#FLUX: --urgency=16

export BINDS='${BINDS},${WORKINGDIR}:${WORKINGDIR}'
export blob='$WORKINGDIR/blobtools'

echo "Some Usable Environment Variables:"
echo "================================="
echo "hostname=$(hostname)"
echo "\$SLURM_JOB_ID=${SLURM_JOB_ID}"
echo "\$SLURM_NTASKS=${SLURM_NTASKS}"
echo "\$SLURM_NTASKS_PER_NODE=${SLURM_NTASKS_PER_NODE}"
echo "\$SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}"
echo "\$SLURM_JOB_CPUS_PER_NODE=${SLURM_JOB_CPUS_PER_NODE}"
echo "\$SLURM_MEM_PER_CPU=${SLURM_MEM_PER_CPU}"
cat $0
module load singularity/3.8.7
WORKINGDIR=${pipedir}
IMAGE_NAME=blobtoolkit.sif
export BINDS="${BINDS},${WORKINGDIR}:${WORKINGDIR}"
SINGIMAGEDIR=${pipedir}/singularities
SINGIMAGENAME=${IMAGE_NAME}
export blob="$WORKINGDIR/blobtools"
if [ -f ${pipedir}/singularities/${IMAGE_NAME} ]; then
    echo "Singularity image exists"
 else
    echo "Singularity image does not exist"
        singularity pull -F ${pipedir}/singularities/${IMAGE_NAME} docker://genomehubs/blobtoolkit:4.3.2
fi
PORT1=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
PORT2=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "#############"
echo "#############"
echo "you must open a new terminal on your LOCAL machine and run this:"
echo "ssh -NL ${PORT1}:${SLURMD_NODENAME}:${PORT1} -NL ${PORT2}:${SLURMD_NODENAME}:${PORT2} c23048124@iago.bios.cf.ac.uk"
echo "then go to: localhost:${PORT1} in your browser"
singularity exec --contain --bind $BINDS --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} blobtools host --port $PORT1 --api-port $PORT2 ${blob}/datasets
