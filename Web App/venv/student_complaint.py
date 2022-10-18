from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/viewcom')
def view_complaint():
    return render_template('view-complaint.html')

@app.route('/makecomp')
def make_complaint():
    return render_template('make-complaint.html')

@app.route('/comdetails')
def complaint_detail():
    return render_template('complaint-detail.html')

@app.route('/delete')
def delete_complaint():
    return render_template('complaint-detail.html')

@app.route('/close')
def close_complaint():
    return render_template('complaint-detail.html')