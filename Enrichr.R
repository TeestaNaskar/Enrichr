setwd("/Users/teestanaskar/Dropbox/Teesta/Brain/Human/Bothsex/RNAseq/DEG")

library(openxlsx)
library(enrichR)
library(glue)
library(rlist)
library(STRINGdb)
library(dplyr)
library(forcats)

data = read.xlsx("DS_DEGs_Deseq2.xlsx", sheet = 2)
#customize variables
pval_threshold = 0.05
symbol_column = 'Gene.name'
species = 'human'
#note: row column is for gene names
#Enrichr
dbs = c('GO_Biological_Process_2023', 'GO_Cellular_Component_2023', 'GO_Molecular_Function_2023',
        'KEGG_2021_Human', 'WikiPathway_2023_Human','DisGeNET', 'TRANSFAC_and_JASPAR_PWMs', 'Epigenomics_Roadmap_HM_ChIP-seq', 'Human_Phenotype_Ontology', 'SynGO_2024')
gene = data$Gene.name[data$pvalue < 0.05]
output = enrichr((data$Gene.name), databases=dbs)
output = enrichr((data$Gene.name[data$pvalue< 0.05]), databases=dbs)
#Save Enrichr output as Excel file
output = list.prepend(output, data[data$pvalue< 0.05,])
filename = "humanDS_brain_bothsex.xlsx"
folder = "../Enrichr"
write.xlsx(output, glue(folder, filename))
