import pymysql
from flask import Flask, render_template, request, redirect, url_for
app = Flask(__name__)

def create_connection():
    return pymysql.connect(
        host='localhost',    #'10.0.0.17'
        user='root',         #'username'
        password='********', #'my_password'
        db='test_database',  #'username_mydatabase'
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route('/')
def home():
    with create_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM people")
            result = cursor.fetchall()
    return render_template('index.html', result=result)

@app.route('/add', methods=['GET', 'POST'])
def add_person():
    if request.method == 'POST':
        with create_connection() as connection:
            with connection.cursor() as cursor:
                sql = "INSERT INTO people (first_name, last_name, house) VALUES (%s, %s, %s)"
                values = (request.form['first_name'], request.form['last_name'], request.form['house'])
                cursor.execute(sql, values)
                connection.commit()
        return redirect(url_for('home'))
    else:
        return render_template('add.html')

if __name__ == '__main__':
    import os
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555
    app.run(HOST, PORT, debug=True)
