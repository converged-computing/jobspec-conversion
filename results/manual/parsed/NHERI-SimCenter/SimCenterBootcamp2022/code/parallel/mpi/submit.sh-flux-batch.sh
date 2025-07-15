#!/bin/bash
#FLUX: --job-name=persnickety-animal-4044
#FLUX: --urgency=16

module petsc    # load any needed modules, these just examples
moduele load list
ibrun ./a.out
