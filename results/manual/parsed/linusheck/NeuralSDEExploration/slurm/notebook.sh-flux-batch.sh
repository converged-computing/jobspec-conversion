#!/bin/bash
#FLUX: --job-name=plutogpu
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
NOTEBOOKPORT=`shuf -i 8000-8500 -n 1`
TUNNELPORT=`shuf -i 8501-9000 -n 1`
echo "On your local machine, run:"
echo ""
echo "ssh -L$NOTEBOOKPORT:localhost:$TUNNELPORT linushe@${SLURM_SUBMIT_HOST}.pik-potsdam.de -N"
echo ""
echo "To stop this notebook, run 'scancel $SLURM_JOB_ID'"
ssh -R$TUNNELPORT:localhost:$NOTEBOOKPORT $SLURM_SUBMIT_HOST -N -f
JULIA_REVISE_POLL=1 JULIA_DEBUG=CUDA_Driver_jll srun -n1 /home/linushe/julia-1.9.0/bin/julia --project=/home/linushe/neuralsdeexploration_gpu -e "using Pluto; Pluto.run(port=$NOTEBOOKPORT)"
