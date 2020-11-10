CREATE TABLE IF NOT EXISTS expense_item (
	expense_item_id INTEGER NOT NULL,
	expense INTEGER NOT NULL,
	quantity FLOAT NOT NULL,
	cost_per_unit_item FLOAT,
	total_cost FLOAT,
	item INTEGER NOT NULL,
	PRIMARY KEY(expense_item_id),
	FOREIGN KEY(expense) REFERENCES Expense(expense_id),
	FOREIGN KEY(item) REFERENCES Inventory_item(item_id)
);

CREATE TABLE IF NOT EXISTS Crop(
	name VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	PRIMARY KEY(name)
);

CREATE TABLE IF NOT EXISTS Livestock(
	name VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	PRIMARY KEY(name)
);
CREATE TABLE IF NOT EXISTS Livestock_location(
	location_number INTEGER NOTNULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50) NOTNULL,
	district VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS Shelter(
	shelter_number INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50),
	location INTEGER NOTNULL,
	FOREIGN KEY(location) REFERENCES Livestock_location(location_number) 
);

CREATE TABLE IF NOT EXISTS Livestock_group(
    group_id INTEGER NOTNULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50),
    livestock VARCHAR(50) NOTNULL,
    count INTEGER NOTNULL,
    FOREIGN KEY(Livestock) REFERENCES Livestock(name)
);

CREATE TABLE IF NOT EXISTS Livestock_task(
	task_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50),
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	status VARCHAR(50) NOT NULL,
	responsible_person INTEGER NOT NULL,
	category VARCHAR(50) NOT NULL,
	livestock VARCHAR(50),
	location INTEGER,
	FOREIGN KEY(livestock) REFERENCES Livestock(name),
	FOREIGN KEY(responsible_person) REFERENCES Employee(employee_id),
	FOREIGN KEY(location) REFERENCES Livestock_location(location_number)
);

CREATE TABLE IF NOT EXISTS Field(
	field_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50),
	location VARCHAR(50),
	usable_area FLOAT NOT NULL,
	soil_type VARCHAR(50),
	ownership_type VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Crop_task(
	task_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50),
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	status VARCHAR(50) NOT NULL,
	responsible_person INTEGER NOT NULL,
	category VARCHAR(50) NOT NULL,
	crop VARCHAR(50),
	field INTEGER,
	FOREIGN KEY(crop) REFERENCES Crop(name),
	FOREIGN KEY(responsible_person) REFERENCES Employee(employee_id),
	FOREIGN KEY(field) REFERENCES Field(field_id) 
);

CREATE TABLE IF NOT EXISTS Crop_task_machinery_usage(
	usage_number INTEGER NOT NULL PRIMARY KEY,
	date DATE NOT NULL,
	machinery INT NOT NULL,
	hour_count INT,
	area_treated FLOAT,
	total_cost FLOAT,
	task INTEGER NOT NULL,
	FOREIGN KEY(machinery) REFERENCES Machinery(machinery_id),
	FOREIGN KEY(task) REFERENCES Crop_task(task_id) 
);

CREATE TABLE IF NOT EXISTS Livestock_task_machinery_usage(
	usage_number INTEGER NOT NULL PRIMARY KEY,
	date DATE NOT NULL,
	machinery INT NOT NULL,
	hour_count INT,
	area_treated FLOAT,
	total_cost FLOAT,
	task INTEGER NOT NULL,
	FOREIGN KEY(machinery) REFERENCES Machinery(machinery_id),
	FOREIGN KEY(task) REFERENCES Livestock_task(task_id) 
);

CREATE TABLE IF NOT EXISTS Crop_task_custom_item_usage(
	usage_id INTEGER NOT NULL PRIMARY KEY,
	item_name VARCHAR(50) NOT NULL,
	category VARCHAR(50),
	quantity FLOAT,
    total_cost FLOAT,
	date DATE NOT NULL,
	task INTEGER NOT NULL,
	FOREIGN KEY(task) REFERENCES Crop_task(task_id)
);

CREATE TABLE IF NOT EXISTS Livestock_task_custom_item_usage(
	usage_id INTEGER NOT NULL PRIMARY KEY,
	item_name VARCHAR NOT NULL,
	category VARCHAR(50),
	quantity FLOAT,
    total_cost FLOAT,
	date DATE NOT NULL,
	task INTEGER NOT NULL,
	FOREIGN KEY(task) REFERENCES Livestock_task(task_id)
);

    CREATE TABLE IF NOT EXISTS Crop_task_labour(
        work_id INTEGER NOT NULL PRIMARY KEY,
        date DATE NOT NULL,
        worker VARCHAR(50) NOT NULL,
        hour_count INTEGER,
        area_treated FLOAT,
        total_cost FLOAT,
        task INTEGER NOT NULL,
        FOREIGN KEY(task) REFERENCES Crop_task(task_id)
    );
    CREATE TABLE IF NOT EXISTS Livestock_task_labour(
        work_id INTEGER NOT NULL PRIMARY KEY,
        date DATE NOT NULL,
        worker VARCHAR(50) NOT NULL,
        hour_count INTEGER,
        area_treated FLOAT,
        total_cost FLOAT,
        task INTEGER NOT NULL,
        FOREIGN KEY(task) REFERENCES Livestock_task(task_id)
    );

    CREATE TABLE IF NOT EXISTS Crop_task_inventory_item_usage(
        usage_id INTEGER NOTNULL PRIMARY KEY,
        item INTEGER NOTNULL,
        quantity FLOAT,
        FOREIGN KEY(item) REFERENCES Inventory_item(item),
        FOREIGN KEY(task) REFERENCES Crop_task(task_id)
    );

CREATE TABLE IF NOT EXISTS Livestock_task_inventory_item_usage(
    usage_id INTEGER NOT NULL PRIMARY KEY,
    item INTEGER NOT NULL,
    quantity FLOAT,
	FOREIGN KEY(item) REFERENCES Inventory_item(item),
    FOREIGN KEY(task) REFERENCES Livestock_task(task_id)
);

CREATE TABLE IF NOT EXISTS Season(
	season_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	name VARCHAR(50),
	crop VARCHAR(50),
	yield FLOAT,
	yield_unit VARCHAR(10),
	status VARCHAR(50) NOT NULL,
	FOREIGN KEY(crop) REFERENCES Crop(name)
);

CREATE TABLE IF NOT EXISTS Linked_area(
	field INTEGER NOT NULL,
	crop VARCHAR(50) NOT NULL,
	area FLOAT NOT NULL,
	production_type VARCHAR(50),
	variety VARCHAR(50),
	season INTEGER,
	PRIMARY KEY(field, crop),
	FOREIGN KEY(field) REFERENCES Field(field_id),
	FOREIGN KEY(crop) REFERENCES Crop(name),
	FOREIGN KEY(season) REFERENCES Season(season_id)
);