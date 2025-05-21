-- execute the following statements to create tables

-- regions

-- USE company_db;      En Oracle no neseitamos el USE para entrar en la base de datos desde oracle developer. Ya que entramos iniciando sesión desde la interfaz gráfica.

CREATE TABLE regions (
    region_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    region_name VARCHAR2(50) NOT NULL
);

-- Countries
CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR2(40) NOT NULL,
    region_id NUMBER,
    CONSTRAINT fk_countries_regions FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
        ON DELETE CASCADE
);

-- Locations
CREATE TABLE locations (
    location_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    address VARCHAR2(255) NOT NULL,
    postal_code VARCHAR2(20),
    city VARCHAR2(50),
    state VARCHAR2(50),
    country_id CHAR(2),
    CONSTRAINT fk_locations_countries FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
        ON DELETE CASCADE
);

-- Warehouses
CREATE TABLE warehouses (
    warehouse_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_name VARCHAR2(255),
    location_id NUMBER,
    CONSTRAINT fk_warehouses_locations FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
        ON DELETE CASCADE
);

-- Employees
CREATE TABLE employees (
    employee_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(255) NOT NULL,
    last_name VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    phone VARCHAR2(50) NOT NULL,
    hire_date DATE NOT NULL,
    manager_id NUMBER,
    job_title VARCHAR2(255) NOT NULL,
    CONSTRAINT fk_employees_manager FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON DELETE CASCADE
);

-- Product Categories
CREATE TABLE product_categories (
    category_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR2(255) NOT NULL
);

-- Products
CREATE TABLE products (
    product_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR2(255) NOT NULL,
    description VARCHAR2(2000),
    standard_cost NUMBER(9,2),
    list_price NUMBER(9,2),
    category_id NUMBER NOT NULL,
    CONSTRAINT fk_products_categories FOREIGN KEY (category_id)
        REFERENCES product_categories(category_id)
        ON DELETE CASCADE
);

-- Customers
CREATE TABLE customers (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    address VARCHAR2(255),
    website VARCHAR2(255),
    credit_limit NUMBER(8,2)
);

-- Contacts
CREATE TABLE contacts (
    contact_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(255) NOT NULL,
    last_name VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    phone VARCHAR2(20),
    customer_id NUMBER,
    CONSTRAINT fk_contacts_customers FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
);

-- Orders
CREATE TABLE orders (
    order_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    status VARCHAR2(20) NOT NULL,
    salesman_id NUMBER,
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_orders_employees FOREIGN KEY (salesman_id)
        REFERENCES employees(employee_id)
        ON DELETE SET NULL
);

-- Order Items
CREATE TABLE order_items (
    order_id NUMBER,
    item_id NUMBER,
    product_id NUMBER NOT NULL,
    quantity NUMBER(8,2) NOT NULL,
    unit_price NUMBER(8,2) NOT NULL,
    PRIMARY KEY (order_id, item_id),
    CONSTRAINT fk_order_items_products FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);

-- Inventories
CREATE TABLE inventories (
    product_id NUMBER,
    warehouse_id NUMBER,
    quantity NUMBER NOT NULL,
    PRIMARY KEY (product_id, warehouse_id),
    CONSTRAINT fk_inventories_products FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_inventories_warehouses FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE CASCADE
);
