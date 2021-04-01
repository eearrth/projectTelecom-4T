from numpy import *
from numba import jit, prange
from matplotlib import *
from scipy.io import *
from pylab import *
from sklearn.model_selection import *
import time
import numpy as np
import pickle
from pandas import*
import gc
@jit(nopython=True, parallel=True)

# map max min to -1 and 1 function
def mapmaxmin_RZ(X):

	X_std = (X - 3.5*10**-5) / (150-3.5*10**-5)
	return X_std

def mapmaxmin_DST(X):

	X_std = (X + 29.6773) / (7 + 29.6773)
	return X_std

def mapmaxmin_F10(X):

	X_std = (X - 67) / (160.5976 - 67)
	return X_std

def mapmaxmin(X):

	X_std = (X -min(X)) / (max(X) - min(X))
	return X_std

def mapmaxmin_TEC(X):

	#maxvalue = 134.58
        #minvalue = 0.73
	Xstd = (X-0.72114013) / (134.58-0.722114013)
	return Xstd

# rescale function
def rescale_max(X):

	#maxvalue = 134.58
	#minvalue = 0.73
	x = X
	xre = X * (134.58-0.72114013) + 0.72114013
	return xre

#################################################################################
# The function that initiates the values of the weight matrices and bias vectors.
#################################################################################

def init_layers(nn_architecture, seed = 99):
    np.random.seed(seed)
    number_of_layers = len(nn_architecture)
    params_values = {}

    for idx, layer in enumerate(nn_architecture):
        layer_idx = idx + 1
        layer_input_size = layer["input_dim"]
        layer_output_size = layer["output_dim"]
        params_values['W' + str(layer_idx)] = np.random.randn(
            layer_output_size, layer_input_size) * 0.1
        params_values['b' + str(layer_idx)] = np.random.randn(
            layer_output_size, 1) * 0.1
    return params_values

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
    Z_curr = np.dot(W_curr, A_prev) + b_curr # linear algreba algorithm

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

#################################################################################
# Calculating the value of the cost function and accuracy
#################################################################################

def get_cost_value(Y_hat, Y):
    m = Y_hat.shape[1]
    cost = -1 / m * (np.dot(Y, np.log(Y_hat).T) + np.dot(1 - Y, np.log(1 - Y_hat).T))
    return np.squeeze(cost)

#################################################################################
# calculate accuracy
#################################################################################
def convert_prob_into_class(probs):
    probs_ = np.copy(probs)
    probs_[probs_ > 0.5] = 1
    probs_[probs_ <= 0.5] = 0
    return probs_
def get_accuracy_value(Y_hat, Y):
    Y_hat_ = convert_prob_into_class(Y_hat)
    return (Y_hat_ == Y).all(axis=0).mean()

#################################################################################
# single backward propagation step
#################################################################################

def single_layer_backward_propagation(dA_curr, W_curr, b_curr, Z_curr, A_prev, activation):
    m = A_prev.shape[1]


    if activation == "relu":
        backward_activation_func = relu_backward
    elif activation == "sigmoid":
        backward_activation_func = sigmoid_backward
    else:
        raise Exception('Non-supported activation function')

    dZ_curr = backward_activation_func(dA_curr, Z_curr)
    dW_curr = np.dot(dZ_curr, A_prev.T) / m
    db_curr = np.sum(dZ_curr, axis=1, keepdims=True) / m
    dA_prev = np.dot(W_curr.T, dZ_curr)

    return dA_prev, dW_curr, db_curr

#################################################################################
# Full backward propagation step
#################################################################################

def full_backward_propagation(Y_hat, Y, memory, params_values, nn_architecture):
    	grads_values = {}
    	m = Y.shape[1]
    	Y = Y.reshape(Y_hat.shape)

    	dA_prev = - (np.divide(Y, Y_hat) - np.divide(1 - Y, 1 - Y_hat));

    	for layer_idx_prev, layer in reversed(list(enumerate(nn_architecture))):
        	layer_idx_curr = layer_idx_prev + 1
        	activ_function_curr = layer["activation"]

        	dA_curr = dA_prev
        	A_prev = memory["A" + str(layer_idx_prev)]
        	Z_curr = memory["Z" + str(layer_idx_curr)]
        	W_curr = params_values["W" + str(layer_idx_curr)]
        	b_curr = params_values["b" + str(layer_idx_curr)]

        	dA_prev, dW_curr, db_curr = single_layer_backward_propagation(
            	dA_curr, W_curr, b_curr, Z_curr, A_prev, activ_function_curr)

        	grads_values["dW" + str(layer_idx_curr)] = dW_curr
        	grads_values["db" + str(layer_idx_curr)] = db_curr

    	return grads_values

#################################################################################
#  Updating parameters values using gradient descent
#################################################################################

def update(params_values, grads_values, nn_architecture, learning_rate):
    for layer_idx, layer in enumerate(nn_architecture,1):
        params_values["W" + str(layer_idx)] -= learning_rate * grads_values["dW" + str(layer_idx)]
        params_values["b" + str(layer_idx)] -= learning_rate * grads_values["db" + str(layer_idx)]

    return params_values;

#################################################################################
# Training a model
#################################################################################

def train(X, Y, nn_architecture, epochs, learning_rate, test_size,No_feature, size_data, mini_batch):
# def train(X, Y, nn_architecture, epochs, learning_rate):
	params_values = init_layers(nn_architecture, 2)
	cost_history = []
	accuracy_history = []
	RMSE_historytrain = []
	RMSE_historytest = []

	error_historytrain = []
	error_historytest = []

	if test_size <= 0.1:
		X_train = X
		Y_train = Y
		X_test = X_train
		Y_test = Y_train
	else:
		X_train, X_test, Y_train, Y_test = train_test_split(X_norm.reshape((11,220103)).T, y_norm.reshape((1,220103)).T,
						test_size=test_size,
                                                    random_state=45)
		X_train = X_train.T
		X_test = X_test.T
		Y_train = Y_train.T
		Y_test = Y_test.T

	size_data = X_train.shape[1]




	for i in range(epochs):
		ii=0
		jj=1
		for j in prange(size_data):

			Y_hat, cashe = full_forward_propagation(
						X_train[:,ii*No_feature:jj*No_feature].reshape((11,No_feature)), params_values, nn_architecture)

			cost = get_cost_value(Y_hat, Y_train[:,ii*No_feature:jj*No_feature].reshape((1,No_feature)))
			cost_history.append(cost)

			grads_values = full_backward_propagation(Y_hat, Y_train[:,ii*No_feature:jj*No_feature].reshape((1,No_feature)), cashe, params_values, nn_architecture)
			params_values = update(params_values, grads_values, nn_architecture, learning_rate)

			jj = jj+1
			ii = ii+1

		Y_hatts, cashe = full_forward_propagation(X_test, params_values, nn_architecture)
		Y_hattr, cashe = full_forward_propagation(X_train, params_values, nn_architecture)

		RMSE_test = sqrt((sum(Y_test-Y_hatts)**2)/X_test.shape[1])
		RMSE_train = sqrt((sum(Y_train-Y_hattr)**2)/X_train.shape[1])
		error_test = (1/X_test.shape[1])*sum(abs(divide((Y_test-Y_hatts),abs(Y_test))))*100
		error_train = (1/X_train.shape[1])*sum(abs(divide((Y_train-Y_hattr),abs(Y_train))))*100
		error_historytrain.append(error_train)
		error_historytest.append(error_test)
		accuracy = get_accuracy_value(Y_hat,Y_test)
		print('epoch==', i+1,'/', epoch,' RMSE_train ==', RMSE_train,' RMSE_test==',RMSE_test,'cost ==', cost,'error test ==',error_test,'error train ==',error_train,'accuracy==',accuracy)
		print(Y_test)
		print(Y_hatts)
		gc.collect()
		RMSE_historytest.append(RMSE_test)
		RMSE_historytrain.append(RMSE_train)

	return params_values, cost_history, accuracy_history,RMSE_historytest,RMSE_historytrain,error_historytrain,error_historytest


#################################################################################################
# input require No.input * time step
# for test gradient descent method use 1 hidden layer
#################################################################################################
# 4 hidden layer
'''
nn_architecture = [
    {"input_dim": 11, "output_dim": 35, "activation": "sigmoid"},
    {"input_dim": 35, "output_dim": 35, "activation": "sigmoid"},
    {"input_dim": 35, "output_dim": 35, "activation": "sigmoid"},
    {"input_dim": 35, "output_dim": 35, "activation": "sigmoid"},
    {"input_dim": 35, "output_dim": 1, "activation": "sigmoid"},
]
'''
# 1 hidden layer
'''
nn_architecture = [
    {"input_dim": 12, "output_dim": 105, "activation": "sigmoid"},
    {"input_dim": 105, "output_dim": 1, "activation": "sigmoid"},]
'''
# 2 hidden layer

nn_architecture = [
     {"input_dim": 11, "output_dim": 20, "activation": "sigmoid"},
     {"input_dim": 20, "output_dim": 20, "activation": "sigmoid"},
     {"input_dim": 20, "output_dim": 1, "activation": "sigmoid"},
]

# 3 hidden layer
'''
nn_architecture = [
     {"input_dim": 12, "output_dim": 40, "activation": "sigmoid"},
     {"input_dim": 40, "output_dim": 40, "activation": "sigmoid"},
     {"input_dim": 40, "output_dim": 40, "activation": "sigmoid"},
     {"input_dim": 40, "output_dim": 1, "activation": "sigmoid"},
]
'''



# input layer size ,NO.of hidden node, No. of output node
train_maxLoss = 1e-4

# create network that consist of No.of input node
# No. of Hidden layer and No. of Output node
# net = NN.NeuralNetwork(layer_sizes)

#################################################################################
# load input and taget that copute by matlab programing
#################################################################################
X = read_csv("in1.csv")
#print(input) #shape is 466247,10
y = read_csv("out1.csv")
X = X.to_numpy() # shape is 466247,10
#input = input.T
y = y.to_numpy() # shape is 466247,1
y = asarray(y)
X=X.T
y = y.T
X_norm = empty((11, 220103))
X_norm[:] = nan
y_norm = empty((1, 220103))
y_norm[:] = nan
# print(min(y))
# print(X.shape)




#############################################################################
# normalize data to 0 and 1
#############################################################################
# test
# X[0]=lat, X[1]=lon, X[2]=HRS,X[3]=HRC,X[4]=DNS,X[5]=DNC,X[6]=RZ12,X[7]=dst,X[8]=f10.7,X[9]=TEC_past
X_norm[0,:] = cos(2*pi*X[0,:]/360)
#X_norm[0,:] = mapmaxmin(X_norm[0,:])

X_norm[1,:] = cos(2*pi*X[1,:]/360)
#X_norm[1,:] = mapmaxmin(X_norm[1,:])
X_norm[2:6,:] = X[2:6,:]
X_norm[6,:] = mapmaxmin_RZ(X[6,:].reshape((1,220103)))
X_norm[7,:] = mapmaxmin_DST(X[7,:].reshape((1,220103)))
X_norm[8,:] = mapmaxmin_F10(X[8,:].reshape((1,220103)))
#X_norm[9,:] = mapmaxmin_TEC(X[9,:].reshape((1,220103)))
#print(X_norm[8,:])
#print(X_norm[9,:])
#print(X_norm[0,:])
y_norm = mapmaxmin_TEC(y[:,:])

X_norm[9,:] = sin(2*pi*X[1,:]/360)
X_norm[10,:] = sin(2*pi*X[0,:]/360)
#X_norm[10,:] = mapmaxmin(X_norm[10,:])
#X_norm[11,:] = mapmaxmin(X_norm[11,:])
#print(X[2:6,:])

#############################################################################
# Neural Network Parameters
#############################################################################

print('test train Neural Network (MLP)')
print('NN Architect is ', nn_architecture)
epoch = 1000
learn_rate = 0.01
No_feature = 1
size_data = X_norm.shape[1]
mini_batch = 1
test_size = 0.33
print('epoch: ', epoch,' learning rate :', learn_rate,'test size :',test_size)

#############################################################################
# train model Neural Network
#############################################################################

params_values,cost,acc2,RMSE_test,RMSE_train,error_train,error_test = train(X_norm, y_norm, nn_architecture, epoch, learn_rate,
				test_size, No_feature, size_data,mini_batch)
mem,y_pred = full_forward_propagation(X_norm[:,1200:1320], params_values, nn_architecture)
print(rescale_max(mem),'\n')
print(y[:,1200:1320])

#############################################################################
# plot forecast test data
#############################################################################
'''
f=figure(1)
t = [s for s in range(120)]
plot(t,y[:,1200:1320].T)
plot(t,rescale_max(mem).T)
xlabel('HR')
ylabel('TEC scale')
title('TEC forecasting')
f.show()
f.savefig('testfore2_23.png')

f2 = figure(2)
x = [s for s in range(epoch)]
RMSE_test=array(RMSE_test)
RMSE_train=array(RMSE_train)
plot(x,RMSE_test.reshape((1,epoch)).T)
plot(x,RMSE_train.reshape((1,epoch)).T)
xlabel('epoch')
ylabel('RMSE')
title('RMSE data')
f2.legend(['RMSE from test','RMSE from train'], loc=1)
f2.show()
f2.savefig('RMSE2_23.png')

f3 = figure(3)
x = [s for s in range(epoch)]
error_train = array(error_train)
error_test = array(error_test)
plot(x,error_train.reshape((1,epoch)).T)
plot(x,error_test.reshape((1,epoch)).T)
xlabel('epoch')
ylabel('error(%)')
title('% ERROR OF DATA')
f3.legend(['error from train','error from test'], loc=1)
f3.show()
f3.savefig('ERROR2_23.png')
'''
#############################################################################
# save model
#############################################################################

with open('weigth_35.pickle', 'wb') as f:
    pickle.dump(params_values, f)
with open('NN_arc_35.pickle', 'wb') as f:
    pickle.dump(nn_architecture, f)

#############################################################################
