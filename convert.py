from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Load the trained model
model = joblib.load('SVR_1.joblib')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get input data from the request
        data = request.get_json(force=True)
        input_data = np.array(data['features'])

        # Reshape the 1D array to a 2D array
        input_data_2d = input_data.reshape(1, -1)

        # Make predictions using the loaded model
        prediction = model.predict(input_data_2d)

        # Return the prediction as JSON
        return jsonify({"prediction": prediction.tolist()})

    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


##http POST http://127.0.0.1:5000/predict features:='[12.0, 32.0, 32.0, 43.0]'