library(dplyr)

# loading in old items
in_items = read.table("../data/to_replace.csv", header=TRUE)
# in_items$conc[in_items$conc=="-"] = NA

# loading in items matched on concreteness and word length from MRC
matched_items = read.table("../data/matched_abstracts.csv", header=TRUE)

# sampling items from matched_abs to fit distribution of old items on: 1) concreteness, 2) word length, 3) frequency
out_items = data.frame(word=NULL, conc=NULL, word_len=NULL, freq=NULL)
mean_conc = mean(matched_items$conc)  # to deal with missing values
row_index = 1
for (row_index in 1:nrow(in_items)){
  row = in_items[row_index, ]
  conc = as.numeric(row$conc)
  freq = as.numeric(row$freq)
  if (is.na(conc)){
    conc = mean_conc
  }
  len = as.numeric(row$word_len)
  filtered = matched_items[((matched_items$conc<conc+50)&(matched_items$conc>conc-50)&(matched_items$word_len<len+3)&(matched_items$word_len>len-3)
                              &(matched_items$freq)<freq+3.5)&(matched_items$freq)>freq-3.5,]
  sample = sample_n(filtered, 1)
  sampled_word = toString(sample$word)
  out_items = rbind(out_items, sample)
  matched_items = matched_items[matched_items$word!=sampled_word,]
  row_index = row_index + 1
}

write.table(out_items, "../data/out_items.csv")
write.table(matched_items, "../data/matched_abstracts.csv")

