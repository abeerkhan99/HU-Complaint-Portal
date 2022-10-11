from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/view-department')
def view_department():
    return render_template('view-complaint.html')

@app.route('/edit-department')
def edit_department():
    return render_template('view-complaint.html')

@app.route('/add_department')
def add_department():
    return render_template('make-complaint.html')