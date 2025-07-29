#!/bin/bash
#FLUX: --job-name=loopy-milkshake-5428
#FLUX: -t=3600
#FLUX: --urgency=16

module add matlab/r2017b
path_name="`pwd`/$1"
echo $path_name
matlab -nodisplay -nojvm -r "compileOutput('$path_name')"
