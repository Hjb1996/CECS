
# This code is used to sort the results of the enrichment analysis for down-regulated group according to the description,p.adjust and etc., 
# and then get the original enrichment analysis list, common list and unique list, respectively.

setwd("Your current path")

projects <- c("BLCA_Stage","BRCA_Stage","COAD_Stage","HNSC_Stage","KIRC_Stage","KIRP_Stage","LUAD_Stage","STAD_Stage","THCA_Stage")

PCC_cutoff=c(0.60, 0.70, 0.80)
for(pcc_cutoff_item in PCC_cutoff){
  
  down_regulated_list_common <- list()
  down_regulated_list_unqiue <- list()
  down_regulated_list_order <- list()
  projects_count <- 0
  for (ii in projects[2:9]) {
    projects_count <- projects_count + 1
    
    # temp_term_list <- read.xlsx("./generalized_Down_summary.xlsx",sheet =ii)
    temp_term_list <- read.xlsx(paste0("./085/",pcc_cutoff_item,"/","generalized_Down_summary_",pcc_cutoff_item,".xlsx"),sheet =ii)
    temp_term_list_order <- temp_term_list[order(temp_term_list$Description,
                                                 temp_term_list$p.adjust,temp_term_list$Stages),]
    down_regulated_list_order[[projects_count]] <- temp_term_list_order
    
    dup_idx <- duplicated(temp_term_list_order$ID)|duplicated(temp_term_list_order$ID,fromLast = TRUE)
    dup_term <- temp_term_list_order$ID[which(dup_idx==TRUE)]
    down_regulated_list_common[[projects_count]] <-  temp_term_list_order[which(dup_idx==TRUE),]
    
    dim_term <- dim(temp_term_list_order)
    unique_idx <- setdiff(c(1:dim_term[1]),which(dup_idx==TRUE))
    # unique_term <- temp_term_list_order$ID[unique_idx]
    down_regulated_list_unqiue[[projects_count]] <- temp_term_list_order[unique_idx,]
    cat("The task for the ",ii," has been completed!\n")
  }
  
  names(down_regulated_list_order) <- projects[2:9]
  paste0("./085/",pcc_cutoff_item,"/","generalized_Down_summary_",pcc_cutoff_item,".xlsx")
  # write.xlsx(down_regulated_list_order,file = "./generalized_Down_summary_order.xlsx")
  write.xlsx(down_regulated_list_order,file = paste0("./085/",pcc_cutoff_item,"/","generalized_Down_summary_order_",pcc_cutoff_item,".xlsx"))
              
  
  names(down_regulated_list_common) <- projects[2:9]
  # write.xlsx(down_regulated_list_common,file = "./generalized_Down_summary_order_common.xlsx")
  write.xlsx(down_regulated_list_common,file = paste0("./085/",pcc_cutoff_item,"/","generalized_Down_summary_order_common_",pcc_cutoff_item,".xlsx"))
               
  
  names(down_regulated_list_unqiue) <- projects[2:9]
  # write.xlsx(down_regulated_list_unqiue,file = "./generalized_Down_summary_order_unique.xlsx")
  write.xlsx(down_regulated_list_unqiue,file = paste0("./085/",pcc_cutoff_item,"/","generalized_Down_summary_order_unique_",pcc_cutoff_item,".xlsx"))
              
}


