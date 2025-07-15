#!/bin/bash
#FLUX: --job-name=boopy-frito-3493
#FLUX: --priority=16

module petsc    # load any needed modules, these just examples
moduele load list
ibrun ./a.out
