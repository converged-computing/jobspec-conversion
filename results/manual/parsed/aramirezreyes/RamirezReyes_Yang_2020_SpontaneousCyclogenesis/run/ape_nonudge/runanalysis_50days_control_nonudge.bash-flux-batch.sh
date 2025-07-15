#!/bin/bash
#FLUX: --job-name=spicy-soup-0420
#FLUX: -N=3
#FLUX: -t=100800
#FLUX: --urgency=16

export TMPDIR='$SCRATCH'

export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.1/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis; using Distributed; using ClusterManagers; addprocs(SlurmManager(9),m="cyclic",exeflags="--project=/global/u2/a/aramreye/RamirezReyes_Yang_2020_SpontaneousCyclogenesis"); @everywhere using RamirezReyes_Yang_SpontaneousCyclogenesis; RamirezReyes_Yang_SpontaneousCyclogenesis.computebudgets_50days("f5e-4_2km_1000km_control_nonudge";offset_in_days = 0)'
