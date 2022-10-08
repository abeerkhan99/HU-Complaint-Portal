from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/comdetails')
def reset_pass():
    return render_template('complaintdetails.html')