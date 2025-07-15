#!/bin/bash
#FLUX: --job-name=hairy-hippo-0134
#FLUX: -t=3600
#FLUX: --priority=16

module add matlab/r2017b
path_name="`pwd`/$1"
echo $path_name
matlab -nodisplay -nojvm -r "compileOutput('$path_name')"
