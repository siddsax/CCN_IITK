import urllib
def queryWikiNumPages(query):

	qstring = 'https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch='+ query + '&srprop=timestamp&format=json&maxlag=5'
	f = urllib.urlopen(qstring)#.read()
	# print(f)
	s = f.read();
	temp = s[s.find('hits')+6:s.find('hits')+15]
	print(temp)
	out = float(temp[0:temp.find('}')-1]);

	return out;

print(queryWikiNumPages("goal"))