'''script to print basic host info on webpage'''
import os
from datetime import datetime
from flask import Flask
app = Flask(__name__)

@app.route('/')
def get_server_info():
    '''server info func'''
    host_name = os.uname().nodename
    kernel_info = os.uname().release
    stat = os.stat('/')
    creation_date = datetime.fromtimestamp(stat.st_ctime).strftime('%Y-%m-%d %H:%M:%S')
    return f"Host: {host_name}, Kernel: {kernel_info}, Server Created On: {creation_date}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
