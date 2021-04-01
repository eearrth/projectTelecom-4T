from pandas import*
from numpy import*
from sklearn import*
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM, Dropout
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from matplotlib import *
from scipy.io import *
from pylab import *
from tensorflow import keras
from sklearn.preprocessing import StandardScaler
import tensorflow as tf
from tensorflow.keras.metrics import RootMeanSquaredError as RMSE
model = keras.models.load_model("my_model4-2")

def create_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i:(i+look_back),0:9]
        dataX.append(a)
        dataY.append(dataset[i + look_back, 9])
    return numpy.array(dataX), numpy.array(dataY)
lat = 14.5189
lon = 100.1306
input = empty((227950,10))
target = empty((227950,1))

inp1= read_csv("in1.csv")
#print(input) #shape is 466247,10
tar1 = read_csv("out1.csv")
inp1 = inp1.to_numpy() # shape is 466247,10
#inp1[:,6]= inp1[:,6]+20

#inp1[:,7]= inp1[:,7]+4
#inp1[:,8]= inp1[:,8]-50
#input = input.T
tar1 = tar1.to_numpy() # shape is 466247,1
#target = target.T
#print(target) # shape is 466247,1
inp2 = read_csv("solartest.csv")
inp2 = inp2.to_numpy()

#inp2[:,5]= inp2[:,4]+40
#inp2[:,6]= inp2[:,6]-50
input[0:220103,:] = inp1
input[220103:227950,2:9] = inp2
input[220103:227950,0] = lat
input[220103:227950,1] = lon
#input[:,8]= input[:,8]-20

scaler = StandardScaler()
input[:,0:9] = scaler.fit_transform(input[:,0:9])
target = scaler.fit_transform(target)
dataset = empty((227950,10))
dataset[:,0:10] = input
dataset = dataset[220103:227950,:]
#dataset[0:7847,2:9]=dataset[0:7847,2:9]

look_back = 24
trainX, trainY = create_dataset(dataset, look_back)

# reshape input to be https://shiva-verma.medium.com/understanding-input-and-output-shape-in-lstm-keras-c501ee95c65e
# batchsize,time_step, units
trainX = numpy.reshape(trainX, (trainX.shape[0], look_back , 9))
Y = reshape(trainY,(trainY.shape[0], 1))

# make predictions
y_Predict = model.predict(trainX)
y_Predict = y_Predict
y_Predict = (y_Predict)
print(y_Predict)
#
import pandas as pd
pd.DataFrame(y_Predict).to_csv('SPBR_LSTM.csv')
'''
# Get the current locations and labels.
f=figure(1)
t = [s for s in range(24*5)]
plot(t,Y[0,0:24*5].T)
plot(t,y_Predict[0,0:24*5],'r--')
xlabel('DAY')
ylabel('TEC(TECU)')
title('TEC forecasting at LPBR station')
f.legend(['pred', 'val(real)'], loc='upper left')
f.show()
f.savefig('testforelstm.png')
'''
