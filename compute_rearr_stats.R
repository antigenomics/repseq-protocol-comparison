# devtools::install_github("milaboratory/mirutil")
library(mirutil)
select = dplyr::select

# Load project metadata
metadata.raw <- fread("metadata.txt")
metadata <- metadata.raw %>%
  mutate(sample.id = paste(project, experiment, chain, dilution, amount_ng, replica, sep = "."),
         file.name = paste0("corrected/", sample.id, ".txt.gz"))# %>%
#  select(-fastq.1, -fastq.2)

#fwrite(metadata, "meta.txt", sep = "\t")

# Load clonotype tables
dataset <- metadata %>% read_mixcr_dataset(cores = 80)

#print(dataset)
print("Loaded datasets")
print(str(dataset))

# Filter spike-in
dataset$samples <- dataset$samples %>%
  mclapply(function(x) x %>% 
             filter(aaSeqCDR3 != "CASSFSTCSANYGYTF" &
                      aaSeqCDR3 != "CAVSDLEPNSSASKIIF"),
         mc.cores = 80)

# Compute rearrangement statistics - time consuming
df.stats <- dataset %>% compute_rearr_stats(cores = 80)

# Save metadata & statistics
save(metadata, df.stats, file = "stats.RData")