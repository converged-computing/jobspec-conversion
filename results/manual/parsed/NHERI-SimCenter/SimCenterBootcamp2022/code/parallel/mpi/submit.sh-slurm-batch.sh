#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -n=8
#FLUX: --queue=development
#FLUX: -t=10
#FLUX: --urgency=16

module petsc    # load any needed modules, these just examples
moduele load list
ibrun ./a.out
