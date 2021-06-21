from flask import Flask, request


app = Flask(__name__)

@app.route("/isEven", methods=['GET'])
def index():
    number = int(request.args.get("number"))    
    if number % 2 == 0:
        return 'Even'
    else:
        return 'Odd'

@app.route("/hello", methods=["GET"])
def another_page():
    return "Hello Python !!!"


app.run('0.0.0.0', debug=True, port=5050)