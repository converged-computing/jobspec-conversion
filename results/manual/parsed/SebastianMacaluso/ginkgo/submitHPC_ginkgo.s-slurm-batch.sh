#!/bin/bash
#FLUX: --job-name=ginkgo
#FLUX: -t=122400
#FLUX: --urgency=16

module purge
mkdir -p $SCRATCH/ginkgo/logs
RUNDIR=$SCRATCH/ginkgo/runs/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
outdir=/scratch/sm4511/ginkgo/data/MCMC
singularity exec --nv \
	    --overlay /scratch/sm4511/pytorch1.7.0-cuda11.0.ext3:ro \
	    /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
	    bash -c "source /ext3/env.sh; python $SCRATCH/ginkgo/src/ginkgo/run_invMassGinkgo_variableJet4vec.py --jetType=QCD --Nsamples=100000 --id=${SLURM_ARRAY_TASK_ID} --minLeaves=8 --maxLeaves=9 --maxNTry=2000000000 --out_dir=${outdir}"
  ## to submit(for 3 jobs): sbatch --array 0-2 submitHPC_ginkgo.s
