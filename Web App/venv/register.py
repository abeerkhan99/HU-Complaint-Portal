from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/registration')
def register():
    return render_template('register.html')


@app.route('/register-submit', methods = ['GET', 'POST'])
def register_submit():
    if request.method == 'POST':
        return redirect('/login')
    else:
        return render_template('register.html')