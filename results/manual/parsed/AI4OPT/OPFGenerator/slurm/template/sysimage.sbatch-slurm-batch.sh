#!/bin/bash
#FLUX: --job-name=sysimage_OPF
#FLUX: -t=3600
#FLUX: --urgency=16

. {{{:env_path}}}
cd {{{:opfgenerator_dir}}}
mkdir app
julia --project=. -t1 --trace-compile=app/precompile.jl {{{:sampler_script}}} {{{:config_file}}} 1 1
julia --project=. slurm/make_sysimage.jl
