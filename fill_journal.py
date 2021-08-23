import psycopg2
import datetime
from datetime import timedelta
from faker import Faker
import random

def random_date(start_date, end_date):
    fake = Faker()
    return fake.date_between(start_date, end_date)
    
def set_journal_data():
    with psycopg2.connect("dbname=postgres user=postgres password = '1234'") as conn:
        cur = conn.cursor()
        get_list_sql = '''select s.student_id, sdl.class_id  from students as s inner join schedule as sdl on sdl.student_id = s.student_id;'''   
        insert_sql = """insert into journal (student_id, class_id, grade, date_) values (%s,%s,%s,%s)"""
        cur.execute(get_list_sql)
        res = cur.fetchall()
        start_date = datetime.date(year=2020, month=1, day=1)
        for r in res:
            for i in range(7):
                task= (*(r), random.randrange(7, 12, 1), str(start_date+timedelta(days = random.randrange(2, 363, 1))))
                cur.execute(insert_sql, task)
        conn.commit()
        cur.close()

if __name__ == '__main__':
    set_journal_data()
