from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/assign')
def reset_pass():
    return render_template('assigningcomplaint.html')