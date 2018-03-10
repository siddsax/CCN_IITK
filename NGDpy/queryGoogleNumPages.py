import urllib
import time
import math

def queryGoogleNumPages(query):
	offset = 23;
	qstring = 'https://www.google.co.in/search?source=hp&ei=-ZWFWrPvGY20vwTv9ZGgAQ&q=' + query
	s = urllib.urlopen(qstring).read()

	sIdx = s.find('id="resultStats"');
	eIdx = s[sIdx:].find(' results');
	# eIdx = eIdx[1];

	rstring = s[sIdx+offset:sIdx+eIdx-1];
	# out = math.log(float(rstring));

	time.sleep(2)           # very important if you don't want to seem like a bot and have your IP blocked by Google
	return rstring

print(queryGoogleNumPages("hello"))