from computeNGD import computeNGD
import numpy as np

Question = ["India", "shares", "longest", "international", "boundary", "with", "which", "country"]
Options = [["Bangladesh"], ["China"], ["Nepal"], ["Bhutan"]]

attention = np.zeros(len(Question))
print(attention)
for i in range(len(Question)):
	for j in range(len(Question)):
		if(Question[i] != Question[j]):
			attention[i] += computeNGD(Question[i],Question[j])
			print(attention[i])
			
attention[i] = attention[i]/np.sum(attention)
scores = np.zeros(len(Options))
for i in Options:
	for j in i: 
		for k in range(len(Question)):
			scores += attention[k]*computeNGD(Question[k],j)		
		scores = scores/len(i) #Equal attention

print(np.argmin(scores))

