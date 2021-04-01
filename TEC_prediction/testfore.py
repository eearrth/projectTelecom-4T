import time
import numpy as np
import pickle
from numpy import *
from matplotlib import *
from scipy.io import *
from sklearn.metrics import mean_squared_error
from pylab import *
t = time.time()
from itertools import chain
# function Normalize
#seterr(divide='ignore', invalid='ignore')
def mapmaxmin_RZ(X):
	X_std = (X - 3.5*10**-5) / (150-3.5*10**-5)
	return X_std

def mapmaxmin_DST(X):
	#
	X_std = (X + 29.6773) / (7+29.6773)
	return X_std

def mapmaxmin_F10(X):
	#160.5976
	#67
	X_std = (X - 67) / (160.5976 - 67)
	return X_std

def mapmaxmin(X):
	V=amin(X)
	W=amax(X)
	X_std = (X - V)/(W - V)
	return X_std

def mapmaxmin_TEC(X):

	#maxvalue = 134.58
    #minvalue = 0.73
	Xstd = (X-0.73) / (134.58-0.73)
	return Xstd


# rescale of TEC function
def rescale_max(X):

	#maxvalue = 134.58
	#minvalue = 0.73
	x = X
	xre = X * (134.58-0.73) + 0.73
	return xre
#################################################################################
# ReLU and Sigmoid activation functions and their derivatives.
#################################################################################

def sigmoid(Z):
    return 1/(1+np.exp(-Z))

def relu(Z):
    return np.maximum(0,Z)

def sigmoid_backward(dA, Z):
    sig = sigmoid(Z)
    return dA * sig * (1 - sig)

def relu_backward(dA, Z):
    dZ = np.array(dA, copy = True)
    dZ[Z <= 0] = 0;
    return dZ;

#################################################################################
# Single layer forward propagation step
#################################################################################

def single_layer_forward_propagation(A_prev, W_curr, b_curr, activation):
    Z_curr = dot(W_curr,A_prev) + b_curr # linear algreba algorithm

    if activation == "relu":
        activation_func = relu
    elif activation == "sigmoid":
        activation_func = sigmoid
    else:
        raise Exception('Non-supported activation function')

    return activation_func(Z_curr), Z_curr

#################################################################################
# Full forward propagation step
#################################################################################

def full_forward_propagation(X, params_values, nn_architecture):
	memory = {}
	A_curr = X

	for idx, layer in enumerate(nn_architecture):
		layer_idx = idx + 1
		A_prev = A_curr
		activ_function_curr = layer["activation"]
		W_curr = params_values["W" + str(layer_idx)]
		b_curr = params_values["b" + str(layer_idx)]
		A_curr, Z_curr = single_layer_forward_propagation(A_prev, W_curr, b_curr, activ_function_curr)

		memory["A" + str(idx)] = A_prev
		memory["Z" + str(layer_idx)] = Z_curr
	return A_curr, memory
## main part load weigth and bias of model
pickle_in1 = open("weigth_25.pickle","rb")
params_values = pickle.load(pickle_in1)
#print(params_values['W5'].shape)
pickle_in2 = open("NN_arc_25.pickle","rb")
nn_architecture = pickle.load(pickle_in2)

X=[]
TEC=[]
print('insert doy: ')
doy = input()
############ download data solar ##########
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))
print(doy)


doy=int(doy)+1
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))
print(doy)

doy=int(doy)+1
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))
print(doy)

doy=int(doy)+1
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))

doy=int(doy)+1
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))

doy=int(doy)+1
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))

doy=int(doy)+1
print(doy)
file_solar='solar_'+str(doy)+'.mat'
file_TEC = 'TEC_LPBR'+str(doy)+'.mat'
y=loadmat(file_TEC)
z=loadmat(file_solar)
X.append(z['solar'].reshape((7,24)))
TEC.append(y['TEC1'].reshape((1,24)))
###########################################
#print(X)

TEC=array(TEC)
print(TEC.shape)
X=array(X).reshape((7,24*7))

X_norm = empty((12,24*7))
X_norm[:] = nan
# X[0]=lat, X[1]=lon, X[2]=HRS,X[3]=HRC,X[4]=DNS,X[5]=DNC,
#X[6]=RZ12,X[7]=dst,X[8]=f10.7,X[9]=TEC_past
X_norm[0,:] = cos(2*pi*17.6301/360) #lat
X_norm[1,:] = cos(2*pi*100.0963/360) #lon
X_norm[2:6,:] = X[0:4,:]
X_norm[6,:] = mapmaxmin_RZ(X[4,:].reshape((1,24*7)))
X_norm[7,:] = mapmaxmin_DST(X[5,:].reshape((1,24*7)))
X_norm[8,:] = mapmaxmin_F10(X[6,:].reshape((1,24*7)))
X_norm[9,:] = mapmaxmin_TEC(TEC.reshape((1,24*7)))
X_norm[10,:] = sin(2*pi*100.0963/360) #lon
X_norm[11,:] = sin(2*pi*17.6301/360) #lat
#X_norm[:,24] = nan

yhat,mem = full_forward_propagation(X_norm, params_values, nn_architecture)
yhat=rescale_max(yhat)
yhat = yhat.reshape((1,24*7))

TEC=TEC.reshape((1,24*7))

##############################################################################
# CALCULATE RMSE AND MAE

RMSE = sqrt((sum(TEC[0,0:24*4]-yhat[0,0:24*4])**2)/(24*7))
print(RMSE)

##############################################################################
year=2020
doy=int(doy)-6
time1=datetime.datetime(year, 1, 1) + datetime.timedelta(doy - 1)
time1=time1.strftime('%Y-%m-%d')
time2=datetime.datetime(year, 1, 1) + datetime.timedelta(doy)
time2=time2.strftime('%Y-%m-%d')
time3=datetime.datetime(year, 1, 1) + datetime.timedelta(doy+1)
time3=time3.strftime('%Y-%m-%d')
time4=datetime.datetime(year, 1, 1) + datetime.timedelta(doy+2)
time4=time4.strftime('%Y-%m-%d')
time5=datetime.datetime(year, 1, 1) + datetime.timedelta(doy+3)
time5=time5.strftime('%Y-%m-%d')
##############################################################################
f=figure(1)
locs, labels = xticks()  # Get the current locations and labels.
t = [s for s in range(24*4)]
plot(t,TEC[0,0:24*4])
plot(t,yhat[0,0:24*4],'r--')
xlabel('DAY')
ylabel('TEC(TECU)')
title('TEC forecasting at LPBR station')
#locs, labels = xticks()  # Get the current locations and labels.
#print(locs)

xticks(np.arange(0, 100, step=24))  # Set label locations.
xticks([0, 24, 48, 72, 96], [str(time1),str(time2),str(time3),str(time4),str(time5)],rotation=20)
#plt.figtext(0.5, 0.01, ['RMSE:'+str(RMSE)], ha="center", fontsize=8, bbox={"facecolor":"orange", "alpha":0.5, "pad":5})
#f.text(.5, .05, ['RMSE:'+str(RMSE)], ha='center')
#xlim(0,24)
f.show()
x=int(doy)+4
f.legend(['data from measure','data from model'], loc=1)
f.savefig('testfore'+str(doy)+'-'+str(x)+'.png',dpi=100)
#############################################################################################
TEC=reshape(TEC,(168,1))
yhat=reshape(yhat,(24*7,1))
yer=empty((1,24*4))
yer[:]=nan
for i in range(24*4):
	rms = sqrt((sum(TEC[i] - yhat[i]) ** 2) / (1))
	#rms = mean_squared_error(TEC[i], yhat[i])
	yer[0,i] = rms
#print(yer)
yer=yer.reshape((24*4,1))
yhat=reshape(yhat,(1,24*7))
f2=figure(2)
bar(t,list(chain.from_iterable(yer)))
ylabel('RMSE')
xlabel('DAY')
xticks(np.arange(0, 100, step=24))  # Set label locations.
xticks([0, 24, 48, 72, 96], [str(time1),str(time2),str(time3),str(time4),str(time5)],rotation=20)
#plt.figtext(0.5, 0.01, ['RMSE:'+str(RMSE)], ha="center", fontsize=8, bbox={"facecolor":"orange", "alpha":0.5, "pad":5})
#xlim(0,24)
f2.savefig('testforebar'+str(doy)+'-'+str(x)+'.png',dpi=100)
title('TEC forecasting ERROR')
f2.show()












