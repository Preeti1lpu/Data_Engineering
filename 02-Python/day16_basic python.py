1# Variables & Data Types
name = "Preeti"
salary = 90000
is_active = True
rating = 4.7

#STEP 2: Lists
cities = ['Bangalore','Pune','Delhi']
for city in cities:
    print(city)

#STEP 3: Dictionaries
employee = {
"id":1,
"name":'Alice',
"department":"IT",
"salary":900000
}
print(employee["salary"])

#STEP 4: List of Dictionaries
employees =[
    {'id':1, 'name':'John','dept':'IT'},
    {'id':2, 'name':'vicky','dept':'Finance'}
    ]
    
#STEP 5: File Handling
#Read a file

with open("C:\Data_Engineering\\02-Python\input.txt", 'r') as f:
    data = f.read()
print(data)
with open ("C:\Data_Engineering\\02-Python\input.txt", "w") as f:
    f.write("Hello new file tried")