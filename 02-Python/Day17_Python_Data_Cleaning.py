import csv
with open(r"C:\Data_Engineering\\02-Python\employees.csv","r") as f:
    reader = csv.DictReader(f)
    data = list(reader)
print(data)

cleaned_data  =[]

for row in data:
    row['salary'] =  float(row["salary"] if row["salary"] else 0)
    row['department'] = row["department"] if row["department"] else "unknown"
    row['first_name'] = row['first_name'] if row["first_name"] else "NA"
    row['last_name'] = row['last_name'] if row["last_name"] else "NA"
    cleaned_data.append(row)

for row in  cleaned_data:
    row["full_Name"] = row["first_name"] +" "+ row["last_name"]

outpath = "C:\Data_Engineering\\02-Python\employees_cleaned.csv"

fieldnames = cleaned_data[0].keys()

with open(outpath,"w", newline="") as f:
    writer = csv.DictWriter(f,fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(cleaned_data)

print("cleaned file path", outpath)
