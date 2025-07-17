#!/bin/bash
#FLUX: --job-name=misunderstood-buttface-3572
#FLUX: -N=4
#FLUX: --gpus-per-task=1
#FLUX: -t=7200
#FLUX: --urgency=16

srun julia $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
exit
using Base.Iterators, DrWatson, CUDA, CMBLensing, PtsrcLens, MPIClusterManagers, Pidfile, ProgressMeter
CUDA.allowscalar(false)
CMBLensing.init_MPI_workers(transport="MPI")
sources = [:radio]
surveys = [:deep]
freqs = [90, 148]
ℓmax_datas = [3000, 4000, 5000]
fluxcuts = [2, 5, 10]
polfrac_scales = [1]
sims = PtsrcLens.sims
Nbatch = 16
pool = CachingPool(procs())
grid = product(sources, surveys, freqs, ℓmax_datas, fluxcuts, polfrac_scales, sims)
@showprogress pmap(pool, grid) do (source, survey, freq, ℓmax_data, fluxcut, polfrac_scale, sim)
    config = (;source, survey, freq, ℓmax_data, fluxcut, polfrac_scale, sim)
    pidlock = try
        mkpidlock(MAP_filename("lock"; config...), wait=false, stale_age=60*60)
    catch err
        @warn err
        return
    end
    PtsrcLens.get_MAPs(;config...)
    close(pidlock)
end
CMBLensing.stop_MPI_workers()
