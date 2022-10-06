from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/viewcomp')
def login():
    return render_template('viewcomplaint.html')