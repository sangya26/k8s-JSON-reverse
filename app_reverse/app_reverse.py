import requests
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/reverse', methods=['GET'])
def reverse_message():
    response = requests.get('http://app-service:5000/json')
    original_json = response.json()
    reversed_message = original_json['message'][::-1]
    return jsonify({"id": original_json['id'], "message": reversed_message})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
