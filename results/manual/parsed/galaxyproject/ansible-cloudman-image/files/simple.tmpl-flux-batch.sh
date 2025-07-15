#!/bin/bash
#FLUX: --job-name=<%= job.name %>
#FLUX: --priority=16

R CMD BATCH --no-save --no-restore "<%= rscript %>" /dev/stdout
