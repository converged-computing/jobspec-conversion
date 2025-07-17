#!/bin/bash
#FLUX: --job-name=conspicuous-rabbit-2450
#FLUX: --queue=RM
#FLUX: -t=18000
#FLUX: --urgency=16

from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPooling2D
from flatten import load_data
import numpy as np
(x_train, y_train), (x_valid, y_valid) = load_data(20)
stencil = "{}: {}, {}\n\tPic Max: {}\tLoc Max: {}"
print("---------- Data Before Normalization ----------")
print(stencil.format("  Training Data", x_train.shape, y_train.shape, x_train.max(), y_train.max()))
print(stencil.format("Validation Data", x_valid.shape, y_valid.shape, x_valid.max(), y_valid.max()))
x_train = x_train / 255
x_valid = x_valid / 255
y_train = y_train / 360
y_valid = y_valid / 360
print("\n---------- Data After Normalization ----------")
print(stencil.format("  Training Data", x_train.shape, y_train.shape, x_train.max(), y_train.max()))
print(stencil.format("Validation Data", x_valid.shape, y_valid.shape, x_valid.max(), y_valid.max()))
def cnn_model():
    model=Sequential()
    model.add(Conv2D(32,5,5, padding='same',input_shape=(1024,1024,1,), activation='relu'))
    model.add(MaxPooling2D(pool_size=(2,2), padding='same'))
    model.add(Dropout(0.2))
    model.add(Flatten())
    model.add(Dense(128, activation='relu'))
    model.add(Dense(2, activation='softmax'))
    model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
    return model
model=cnn_model()
model.fit(x_train, y_train, validation_data=(x_valid,y_valid),epochs=10, batch_size=200, verbose=2)
score= model.evaluate(x_valid, y_valid, verbose=0)
print('The error is: %.2f%%'%(100-score[1]*100))
