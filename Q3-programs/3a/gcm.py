import scipy.io as sio
import numpy as np

class gcm():
	def __init__(self,alphas,beta,exemplars,gammas,N):
		self.dim = len(alphas)
		self.alphas = alphas
		self.beta = beta
		self.exemplars = exemplars
		self.gammas = gammas
		self.N = N #dict label,ex

	def d(self, exemplar, data):
		distance = 0
		for i in range(self.dim):
			distance += self.alphas[i]*np.abs(exemplar[i]-data[i])
		# print(distance)
		return distance

	def s(self, exemplar, data):
		x = np.exp(-self.beta*self.d(exemplar, data))
		# print(x)
		return x

	def prediction(self, y):
		n_labels = len(self.gammas)
		ns = np.zeros(n_labels)
		sum_ns = 0
		for i in range(n_labels):
			for j in range(len(self.exemplars)):
				ns[i]+= self.N[(i,j)]*self.s(self.exemplars[j], y)
			ns[i]*=self.gammas[i]
			sum_ns+= ns[i]
		# print(ns)
		ns = ns/sum_ns
		label = np.argmax(ns)
		return label

data = sio.loadmat('height_weight_dataset.mat')
test = np.array(data['y'])
# print(np.shape(test))
# print(np.shape([54,62]))
test = np.concatenate((test, np.array([54,62]).reshape((1,2))), axis=0)
# test = test[-1].reshape((1,2))
train = np.array(data['X']) 
exemplars = np.unique(train[:,:-1],axis=0)
labels = np.unique(train[:,-1],axis=0)-1
np.savetxt('train', train, delimiter=',',fmt='%d')
np.savetxt('test', test, delimiter=',',fmt='%d')

N = {}
for i in range(np.shape(exemplars)[0]):
	for label in labels:
		N[(label,i)] = 0

	for j in range(np.shape(train)[0]):
		if (exemplars[i]==train[j,:-1]).all():
			N[(train[i,-1]-1,i)] += 1

# print(N)
alphas = [5,1]
beta = 1
gammas = [1,1,.5]
model = gcm(alphas, beta, exemplars, gammas, N)

for i in range(np.shape(test)[0]):
	print(test[i])
	print(model.prediction(test[i])) 

