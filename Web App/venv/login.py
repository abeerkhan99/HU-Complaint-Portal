from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/login')
def login():
    return render_template('login.html')


@app.route('/submit', methods = ['GET', 'POST'])
def submit():
    if request.method == 'POST':
        return render_template('homepage.html')
    else:
        return render_template('login.html')