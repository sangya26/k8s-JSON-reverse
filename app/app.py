from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/json', methods=['GET'])
def get_json():
    return jsonify({"id": "1", "message": "Hello world"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
