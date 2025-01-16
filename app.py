import os.path

from flask import Flask, render_template, send_file
from markupsafe import escape
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/building/')
def building():
    return render_template('building/index.html')


@app.route('/contributing/')
def contributing():
    return render_template('contributing/index.html')


@app.route('/learning/')
def learning():
    return render_template('learning/index.html')


@app.route('/learning/days/<day>')
def learning_day(day):
    return render_template(f'learning/days/{escape(day)}')

@app.route('/learning/resources/')
def learning_resources():
    return render_template('learning/resources.html')


@app.route('/learning/downloads/<file>')
def learning_file(file):
    return send_file(f'./static/learning/downloads/{escape(file)}', as_attachment=True)


@app.route('/kernel-api/')
def kernel_api():
    return render_template('kernel-api/index.html')

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)

app.config['TEMPLATES_AUTO_RELOAD'] = True
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
