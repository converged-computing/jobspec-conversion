#!/bin/bash
#FLUX: --job-name=cuquantum
#FLUX: -c=8
#FLUX: --queue=a100_normal_q
#FLUX: --priority=16

module load containers/apptainer
USER=`whoami`
CTNR=/global/arcsingularity/cuquantum-appliance_22.07-cirq.sif
BOPTS="--bind /home/$USER,/projects"
[[ -d /globalscratch/$USER ]] && BOPTS="$BOPTS,/globalscratch/$USER"
cd $SLURM_SUBMIT_DIR
echo "Running three examples in the Nvidia cuQuantum container"
echo "jobid: $SLURM_JOBID, working directory: `pwd`"
apptainer exec --nv $BOPTS $CTNR python /workspace/examples/ghz.py --nqubits 20 --nsamples 10000 --ngpus 1 > ghz_out.$SLURM_JOBID.txt
echo "Ran GHZ example, output written to ghz_out.$SLURM_JOBID.txt"
apptainer exec --nv $BOPTS $CTNR python /workspace/examples/hidden_shift.py --nqubits 20 --nsamples 100000 --ngpus 1 > hidden_shift_out.$SLURM_JOBID.txt
echo "Ran Hidden-Shift example, output written to hidden_shift_out.$SLURM_JOBID.txt"
apptainer exec --nv $BOPTS $CTNR python /workspace/examples/simon.py --nbits 15 --ngpus 1 > simon_out.$SLURM_JOBID.txt
echo "Ran Simon example, output written to simon_out.$SLURM_JOBID.txt"
