#!/bin/bash
#FLUX: --job-name={{{:job_name}}}
#FLUX: --urgency=16

~/bin/julia ~/.julia/v0.5/Multilane/scripts/runsims.jl {{{:object_file_path}}} {{{:list_file_path}}}
