from flask import Flask, render_template, request
from scipy.misc import imread, imresize, imsave
import sys
import os
import re
import base64

from keras.models import load_model
import tensorflow as tf
import numpy as np
import cv2

app = Flask(__name__)

# Path to our saved model
sys.path.append(os.path.abspath("./cnn-mnist"))
#Initialize some global variables


    

global model, graph
model = load_model('./cnn-mnist')
graph = graph = tf.get_default_graph()



@app.route('/')
def index():
    return render_template("index.html")
    
def convertImage(imgData1):
  imgstr = re.search(r'base64,(.*)', str(imgData1)).group(1)
  with open('output.png', 'wb') as output:
    output.write(base64.b64decode(imgstr))
    
def loadImage(filename):
        img_rows = img_cols = 28
        img = cv2.imread(filename, cv2.IMREAD_GRAYSCALE)
        img = imresize(img, (28, 28))
        img = img / 255
        # Reshape from (28,28) to (1,28,28,1) : 1 sample, 28x28 pixels, 1 channel (B/W)
        img = np.expand_dims(img, axis=0)
        img = np.expand_dims(img, axis=0)
        img = np.reshape(img, (1,img_cols,img_rows,1))
        return np.array(img)
    
    
for digit in range(0,10):
    img = "9.png"
    img = loadImage(img)
    classes = model.predict(img)
    predicted = np.argmax(classes)
    print(predicted)
    
@app.route('/predict/', methods=['GET', 'POST'])
def predict():
    print("Leo")
    
    #print(model.summary())
    
    imgData = request.get_data()
    convertImage(imgData)

    
    #img = "./9.png"
    img = loadImage("output.png")
    
    with graph.as_default():
        classes = model.predict(img)
        predicted = np.argmax(classes)
        print(predicted)
        return str(predicted)

    return str(response[0])

    
    print(imgData)
    
    return "leo"

if __name__ == "__main__":
# run the app locally on the given port
    app.run(host='0.0.0.0', port=5000)