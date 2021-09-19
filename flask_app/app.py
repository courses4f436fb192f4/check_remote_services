from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['POST'])
def json_example():

    host_addr = ""
    if request.method == 'POST':
        request_data = request.get_json(force=True)

        host_addr = request_data['failed']
        host_addr += " message on the server"
        return '''{}\n'''.format(host_addr)
