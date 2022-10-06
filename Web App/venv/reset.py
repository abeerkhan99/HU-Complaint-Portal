from flask import Flask, render_template, url_for, request, session, redirect
from app import app


@app.route('/reset')
def reset_pass():
    return render_template('reset.html')


@app.route('/verify', methods = ['GET', 'POST'])
def verify():
    if request.method == 'POST':
        return render_template('reset-pass.html')
    else:
        return render_template('reset.html')

        
@app.route('/reset-password', methods = ['GET', 'POST'])
def reset_password():
    if request.method == 'POST':
        return redirect('/login')
    else:
        return render_template('reset-pass.html')