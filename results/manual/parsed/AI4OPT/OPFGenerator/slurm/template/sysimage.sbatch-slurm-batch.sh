#!/bin/bash
#SBATCH --job-name=sysimage_OPF
#SBATCH --account={{:charge_account}}
#SBATCH --output={{{:logs_dir}}}/sysimage.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem={{:sysimage_memory}}
#SBATCH --time=01:00:00

. {{{:env_path}}}
cd {{{:opfgenerator_dir}}}
mkdir app
julia --project=. -t1 --trace-compile=app/precompile.jl {{{:sampler_script}}} {{{:config_file}}} 1 1
julia --project=. slurm/make_sysimage.jl
