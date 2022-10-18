from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/view-program')
def view_program():
    return render_template('view-complaint.html')

@app.route('/edit-program')
def edit_program():
    return render_template('view-complaint.html')

@app.route('/add-program')
def add_program():
    return render_template('make-complaint.html')
