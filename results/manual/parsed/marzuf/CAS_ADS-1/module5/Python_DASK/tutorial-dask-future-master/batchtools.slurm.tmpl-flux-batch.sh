#!/bin/bash
#FLUX: --job-name=<%=
#FLUX: --urgency=16

<%
log.file = fs::path_expand(log.file)
-%>
<%= if (!is.null(resources$partition)) sprintf(paste0("#SBATCH --partition='", resources$partition, "'")) %>
<%= if (!is.null(resources$ntasks)) sprintf(paste0("#SBATCH --ntasks='", resources$ntasks, "'")) %>
<%= if (!is.null(resources$cpus_per_task)) sprintf(paste0("#SBATCH --cpus-per-task='", resources$cpus_per_task, "'")) %>
<%= if (!is.null(resources$nodes)) sprintf(paste0("#SBATCH --nodes='", resources$nodes, "'")) %>
Rscript -e 'batchtools::doJobCollection("<%= uri %>")'
