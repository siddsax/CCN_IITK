import math
from queryWikiNumPages import queryWikiNumPages

def computeNGD(a,b):
	# lN = math.log(47000000000);         #number of webpages indexed by Google in Feb 2018
	lN = 23000
	la = queryWikiNumPages(a);
	# print(la)
	lb = queryWikiNumPages(b);
	lab = queryWikiNumPages(a + '+' + b);
	# print(la, lb, lab, lN)
	NGD = (max(la,lb) - lab)/(lN - min(la,lb));
	return NGD

# print(computeNGD("gauss","math"))