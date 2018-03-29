
def theSpliter(roughList):
    categoryCol = {}
    category = ''
    workSet = None
    flag = False

    for eachLine in roughList:
        # Moving onto next category
        if eachLine.startswith("---"):
            if flag:
                categoryCol[category].remove(workSet)
                flag = False

            category = eachLine.translate(None, ' -').strip()
            categoryCol[category] = []

            workSet = {}
            categoryCol[category].append(workSet)

        # Moving onto next element in the same category
        elif eachLine == '\n':

            workSet = {}
            categoryCol[category].append(workSet)
            flag = True

        else:
            attr = eachLine[:eachLine.find(':')]
            content = eachLine[eachLine.find(':'):].strip(": ").strip()

            workSet[attr] = content

    return categoryCol


if __name__ == "__main__":
    result = {}

    with open("car-data.txt","r") as fd:
        lines = fd.readlines()

        result = theSpliter(roughList=lines)

    with open("data.sql", "w") as sql:
        # Insert into Customer
        sql.write('\nINSERT INTO Customer VALUES')
        for element in result['Customer']:
            sql.write("\n\t('{}',{},'{}'),".format(element["Name"], element["Age"], element["Email"]))
        sql.write(';\nINSERT INTO Model VALUES')
        for element in result['Model']:
            sql.write("\n\t({},'{}','{}',{},{}),".format(element["ID"], element["Name"], element["Vehicle Type"], element["Model Number"], element["Capacity (Seats)"]))
        sql.write(';\nINSERT INTO Rentalstation VALUES')
        for element in result['RENTALSTATION']:
            sql.write("\n\t({},'{}','{}','{}','{}'),".format(element["Station Code"], element["Name"], element["Address"], element["Area Code"], element["City"]))
        sql.write(';\nINSERT INTO Car VALUES')
        for element in result['CAR']:
            sql.write("\n\t({},'{}',{},{}),".format(element["ID"], element["License Plate Number"], element["Station Code"], element["Model_Id"]))
        sql.write(';\nINSERT INTO Reservation VALUES')
        for element in result['RESERVATION']:
            sql.write("\n\t({},'{}','{}',{},{},'{}'),".format(element["ID"], element["From Date"], element["To Date"], element["Car ID"], element["Old Reservation ID"], element["Status"]))
        sql.write(';\nINSERT INTO Customer_Reservation VALUES')
        for element in result['CUSTOMER_RESERVATION']:
            sql.write("\n\t('{}',{}),".format(element["Customer Email"], element["Reservation ID"]))
        sql.write(';')
