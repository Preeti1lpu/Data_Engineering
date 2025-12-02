import json
#Load JSON data
with open("C:\Data_Engineering\\02-Python\employees.json", "r") as f:
    employees = json.load(f)

for emp in employees:
    emp["updated_salary"]  = emp['salary'] * 1.10

filtered_employees = [e for e in employees if e['updated_salary']>70000]

for emp in filtered_employees:
    if emp['updated_salary'] >80000:
        emp["salary_band"] ="High"
    else:
        emp['salary_band']= "Medium"

with open("C:\Data_Engineering\\02-Python\employees_transformed.json","w") as f:
    json.dump(filtered_employees, f , indent =4)

