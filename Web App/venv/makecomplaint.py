from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/makecomp')
def login():
    return render_template('makecomplaint.html')
