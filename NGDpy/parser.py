import numpy as np
import nltk
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer

ps = PorterStemmer()
lmtzr = WordNetLemmatizer()
question = "These are the questions SWIMMING in DELIGHTed Fashion with leaves."
options = {
	0: "This is op A",
	1: "This is op B",
	2: "This is op C",
	3: "This is op D"
}
 
stop_words = set(stopwords.words('english'))
stop_words.add('.')
word_tokens = word_tokenize(question)
filtered_q = [ps.stem(lmtzr.lemmatize(w.lower())) for w in word_tokens if not w in stop_words]

print(word_tokens)
print(filtered_q)

thefile = open('test.txt', 'w')
for item in filtered_q:
  thefile.write("%s," % item)