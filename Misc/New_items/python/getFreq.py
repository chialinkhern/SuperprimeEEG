import pickle
import pandas as pd

# word-to-frequency dictionary; word frequencies are from Wikipedia
infile = open("../data/word_freq_dict.pkl", "rb")
w2f_dict = pickle.load(infile)

old_abstracts = pd.read_csv("../data/conc(old_abs).csv")
matched_abstracts = pd.read_csv("../data/match(conc,len).csv")

# creating frequency columns
old_abstracts["freq"] = None
matched_abstracts["freq"] = None

# filling in frequency columns
for index, row in old_abstracts.iterrows():
    word = row["word"].lower()
    freq = w2f_dict[word]
    old_abstracts.loc[index, "freq"] = freq

for index, row in matched_abstracts.iterrows():
    word = row["word"].lower()
    freq = w2f_dict[word]
    matched_abstracts.loc[index, "freq"] = freq

# outputting csv files
old_abstracts.to_csv("../data/old_abstracts.csv", index=False)
matched_abstracts.to_csv("../data/matched_abstracts.csv", index=False)
