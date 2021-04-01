from pandas import*
from numpy import*
from sklearn import*
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM, Dropout
# demonstrate data standardization with sklearn
from sklearn.preprocessing import StandardScaler
# demonstrate data standardization with sklearn
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from matplotlib import *
from scipy.io import *
from pylab import *
from tensorflow import keras
from keras.layers import Dropout


# model 1 unknow, model 2 24 hr 200 hidden, model 3 24 hr 400 hidden,model 4 12 hr 100 hidden

def normalise(signal):
    mu = np.mean(signal)
    variance = np.mean((signal - mu)**2)
    signal_normalised = (signal - mu)/(np.sqrt(variance + 1e-8))
    return signal_normalised

# convert an array of values into a dataset matrix
def create_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i:(i+look_back),0:9]
        dataX.append(a)
        dataY.append(dataset[i + look_back, 9])
    return numpy.array(dataX), numpy.array(dataY)

input = read_csv("in1.csv")
#print(input) #shape is 466247,10
target = read_csv("out1.csv")
input = input.to_numpy() # shape is 466247,10
#input = input.T
target = target.to_numpy() # shape is 466247,1
#target = target.T
#print(target) # shape is 466247,1
#input[:,6]= input[:,6]+70
#input[:,7]= input[:,7]-40
#input[:,8]= input[:,8]+50
scaler = StandardScaler()
input[:,0:9] = scaler.fit_transform(input[:,0:9])
target = scaler.fit_transform(target)
dataset = empty((220103,10))

dataset[:,0:10] = input

#dataset[:,10] = target[:,0]
# split into train and test sets
train_size = int(len(dataset) * 0.67)
test_size = len(dataset) - train_size
train, test = dataset[0:train_size,:], dataset[train_size:len(dataset),:]
print(len(train), len(test))


look_back = 24
trainX, trainY = create_dataset(train, look_back)
testX, testY = create_dataset(test, look_back)

# reshape input to be https://shiva-verma.medium.com/understanding-input-and-output-shape-in-lstm-keras-c501ee95c65e
# batchsize,time_step, units
trainX = numpy.reshape(trainX, (trainX.shape[0], look_back , 9))
testX = numpy.reshape(testX, (testX.shape[0], look_back , 9))
trainY = reshape(trainY,(trainY.shape[0], 1))
testY = reshape(testY,(testY.shape[0], 1))

# create and fit the LSTM network
model = Sequential()
model.add(LSTM(240, input_shape=(look_back, 9)))
model.add(Dense(1))

import tensorflow as tf
from tensorflow.keras.metrics import RootMeanSquaredError as RMSE
model.compile(loss='mean_squared_error', optimizer='adam')
model.summary()
history = model.fit(trainX, trainY, epochs=200, batch_size=100, validation_split=0.1, shuffle=True)
train_mse = model.evaluate(trainX, trainY, verbose=0)
test_mse = model.evaluate(testX, testY, verbose=0)

'''
# make predictions
trainPredict = model.predict(trainX)
testPredict = model.predict(testX)
print(testPredict)
'''

# summarize history for accuracy
f = figure(1)
plot(history.history['loss'])
plot(history.history['val_loss'])
title('model loss')
ylabel('loss')
xlabel('epoch')
f.legend(['train', 'validation'], loc='upper left')
f.show()
model.save("my_model4-4")

'''
# make predictions
trainPredict = model.predict(trainX)
testPredict = model.predict(testX)
print(testPredict)
'''
# best at 4-2