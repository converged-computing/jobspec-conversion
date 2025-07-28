#!/bin/bash
#FLUX: --job-name=lightcurve-analysis.job
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --urgency=16

source activate nmma_env
mpiexec -n 10 -hosts=$(hostname) lightcurve-analysis --model $MODEL --interpolation-type tensorflow --svd-path svdmodels --outdir fritz_outdir/$LABEL --label $LABEL --trigger-time $TT --data $DATA --prior priors/$PRIOR.prior --tmin $TMIN --tmax $TMAX --dt $DT --n-tstep 50 --photometric-error-budget 0.1 --svd-mag-ncoeff 10 --svd-lbol-ncoeff 10 --Ebv-max 0.5724 --grb-resolution 5 --jet-type 0 --error-budget 1.0 --sampler pymultinest --sampler-kwargs {} --cpus 1 --nlive 2048 --seed 42 --xlim 0,14 --ylim 22,16 --generation-seed 42 --photometry-augmentation-seed 0 --photometry-augmentation-N-points 10 --conditional-gaussian-prior-N-sigma 1 --plot $SKIP_SAMPLING
