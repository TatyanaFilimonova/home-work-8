import psycopg2
import datetime
from datetime import timedelta
import random

    
def set_journal_data():
    # please input your database credentials in the row below:
    with psycopg2.connect(
            "dbname=postgres user=postgres password = '1234'") as conn:
        cur = conn.cursor()
        get_list_sql = '''select s.student_id, sdl.class_id  from students as s inner join schedule as sdl on sdl.student_id = s.student_id;'''   
        insert_sql = """insert into journal (student_id, class_id, grade, date_) values (%s,%s,%s,%s)"""
        cur.execute(get_list_sql)
        res = cur.fetchall()
        start_date = datetime.date(year=2020, month=1, day=1)
        for r in res:
            for i in range(10):
                task= (*(r), random.randrange(7, 12, 1),
                       str(start_date+timedelta(
                           days = random.randrange(2, 363, 1))))
                # some times there are could be error with unique
                # constraint, because random values is not really random....
                # so after inserting every row we have to commit changes
                try:
                    cur.execute(insert_sql, task)
                    conn.commit()
                except:
                    continue
        cur.close()

if __name__ == '__main__':
    set_journal_data()
