# Lab 11

Python file: [lab11.py](./lab11.py)

```python
from pprint import pprint
from dateutil.parser import parse
from pymongo import MongoClient

client = MongoClient('mongodb://localhost')
db = client.get_database('test')
collection = db.get_collection('restaurants')


class Ex1:
    def firstPart(self):
        for item in collection.find({'cuisine': "Indian"}):
            pprint(item)

    def secondPart(self):
        for item in collection.find({"$or": [{'cuisine': "Indian"}, {'cuisine': "Thai"}]}):
            pprint(item)

    def thirdPart(self):
        for item in collection.find():
            address = item['address']
            if address['building'] == "1115" and address['street'] == "Rogers Avenue" and address["zipcode"] == "11226":
                pprint(item)


class Ex2:
    def task(self):
        data = {
            "address": {
                "building": "1480",
                "coord": [
                    -73.9557413,
                    40.7720266
                ],
                "street": "2 Avenue",
                "zipcode": "10075"
            },
            "borough": "Manhattan",
            "cuisine": "Italian",
            "grades": [
                {
                    "date": {
                        "$date": parse("2014-10-01T00:00:00Z")
                    },
                    "grade": "A",
                    "score": 11
                }
            ],
            "name": "Vella",
            "restaurant_id": "41704620"
        }

        collection.insert_one(data)


class Ex3:
    def firstPart(self):
        collection.delete_one({'borough': 'Manhattan'})

    def secondPart(self):
        collection.delete_many({'cuisine': 'Thai'})


class Ex4:
    def task(self):
        for item in collection.find():
            if item['address']['street'] == "Rogers Avenue":
                for grade in item['grades']:
                    if grade['grade'] == "C":
                        collection.delete_one(item)
                        break
                else:
                    item_grades = item['grades']
                    item_grades.append(
                        {
                            "date": {
                                "$date": parse("2022-04-25T00:00:00Z")
                            },
                            "grade": "C",
                            "score": 0
                        }
                    )
                    collection.update_one({'_id': item['_id']}, {'$set': {'grades': item_grades}})


ex1 = Ex1()
ex2 = Ex2()
ex3 = Ex3()
ex4 = Ex4()
ex4.task()
```
