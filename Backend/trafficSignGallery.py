#   ===============> code by: ✪ 𝕊𝔸𝕃𝕄𝔸ℕ ✪ <=============== 
# TRAFFIC SIGN RECOGNITION FLASK API
# @MuhammadSalman
# predict

from flask import Flask, request, jsonify
import numpy as np
import cv2 
from keras.models import load_model
from traffic_sign_classes import classes

app = Flask(__name__)


model_path = "./Trained Models/TSM_CNN_H5.h5"
model = load_model(model_path)

# PRE-PROCESSING
def grayScale(img):
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    return img

def equalize(img):
    img = cv2.equalizeHist(img)
    return img 

def preProcessing(img):
        img = grayScale(img) 
        img = equalize(img) 
        img = img/255       
        return img

def getSignName(classNo):
    return classes.get(classNo)


def model_predict(img, model):
     img = cv2.resize(img, (64,64))
     img = preProcessing(img)
     img = np.expand_dims(img, axis=0)

    #prediction
     predictions = model.predict(img)
     predicted_class = np.argmax(predictions)
     predicted_prob = predictions[0][predicted_class]

     return predicted_class, predicted_prob

#   ===============> code by: ✪ 𝕊𝔸𝕃𝕄𝔸ℕ ✪ <=============== 
@app.route('/predict_image', methods=['POST'])
def predict():
     if request.method == 'POST':
          print("Requesting File: ", request.files)
          if 'File' not in request.files:
               return jsonify({'Error 1': 'No file part'})
          
          gallery_file = request.files['File']
          if gallery_file == '':
               return jsonify({'Error 2': 'No Selected File'})
          
          img = cv2.imdecode(np.frombuffer(gallery_file.read(), np.uint8), cv2.IMREAD_COLOR)
          predicted_class, predicted_prob = model_predict(img, model)
          if predicted_prob >= 0.85:
               predictedSign = getSignName(predicted_class)
               return jsonify({'Prediction':predictedSign, 'Confidence':float(predicted_prob)})
          else:
               return jsonify({'Prediction':'No Sign Identified', 'Confidence':float(predicted_prob)})
          

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000,debug=True)
#   ===============> code by: ✪ 𝕊𝔸𝕃𝕄𝔸ℕ ✪ <=============== 