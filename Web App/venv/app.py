from flask import Flask, render_template, url_for, request, session, redirect


# app instance
app = Flask(__name__, template_folder='Template')
# for sessions
app.secret_key = 'BAD_SECRET_KEY'

# routing
@app.route('/')
def home():
    return render_template('welcome.html')

import login
import register
import reset
import dashboard