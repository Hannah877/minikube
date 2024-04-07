from fastapi import FastAPI
from sqlalchemy import create_engine, text
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
engine = create_engine("mysql+pymysql://root:root@mysql/sakila")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/table")
def get_customers():
    with engine.connect() as connection:
        result = connection.execute(text("""
            SELECT customer.first_name, customer.last_name, customer.email, city.city
            FROM customer
            JOIN address ON customer.address_id = address.address_id
            JOIN city ON address.city_id = city.city_id
            JOIN country ON city.country_id = country.country_id
            WHERE country.country = 'Canada'
            ORDER BY city.city;
        """))
        customers = [
            {
                "first_name": row[0],
                "last_name": row[1],
                "email": row[2],
                "city": row[3]
            } for row in result
        ]
    return customers
