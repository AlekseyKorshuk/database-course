CREATE TABLE "Group" (
    groupId INT NOT NULL,
    PRIMARY KEY (groupId)
);

CREATE TABLE "Plant" (
    plantId INT NOT NULL,
    companyId INT,
	FOREIGN KEY (plantId) REFERENCES Company(companyId),
    PRIMARY KEY (plantId)
);

CREATE TABLE "Company" (
    companyId INT NOT NULL,
    groupId INT,
	FOREIGN KEY (companyId) REFERENCES "Group"(groupId),
    PRIMARY KEY (companyId)
);

CREATE TABLE Item (
    itemId INT NOT NULL,
    plantId INT,
	FOREIGN KEY (itemId) REFERENCES Plant(plantId),
    PRIMARY KEY (itemId)
);
 
