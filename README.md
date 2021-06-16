# README

This project is a templates folder for devonfw's CobiGen code generator. 

Using the OpenAPI plugin, it generates a basic Python Flask CRUD application for a table declared from a component in a .yml file.

The project should be extracted in the `CobiGen_Templates` folder along with the other template folders and the `context.xml` file. 

A new trigger to the `context.xml` must be added in order to set up the CobiGen CLI. Edit the file by adding at the top of the list:

```
  <trigger id="crud_openapi_python" type="openapi" templateFolder="crud_openapi_python">
    <containerMatcher type="element" value="openAPIFile"/>
    <matcher type="element" value="EntityDef">
      <variableAssignment type="extension" key="rootPackage" value="x-rootpackage"/>
      <variableAssignment type="property" key="component" value="componentName"/>
      <variableAssignment type="property" key="entityName" value="name"/>
    </matcher>
</trigger>
```

The contents of this projects are:

* `templates.xml`
* templates
    * `requirements.txt`
    * `config.py`: declares the "Config" class which represents the Flask-SQLAlchemy database configuration.
    * app:
        * `__init__.py`.ftl: FreeMarker template declaring the application and the database.
        * `${variables.entityName#cap_first}Model.py.ftl`: FreeMarker template delcaring the table with the entity's attributes as columns
        * `${variables.entityName#cap_first}Routes.py.ftl`: FreeMarker template declaring the service returning JSON objeccts for the GET, POST, PUT and DELETE methods.

## templates.xml
A file for code generation purposes declaring the "CRUD Python Flask" increment that will be available for selection from the CobiGen CLI.

## templates/
The folder containing the basic application structure including all the files that will be generated.

## requirements.txt
A list of all packages required to run the application and the database. Encoded in UTF-8.

## config.py
Declares the "Config" class corresponding to the Flask-SQLAlchemy database configuration.

## __init__.py.ftl
A FreeMarker template for the Python file declaring the Flask application and the Flask-SQLAlchemy database. Variables are used to import the Model and Routes files.

## ${variables.entityName#cap_first}Model.py.ftl
A FreeMarker template for the Python file declaring the Flask-SQLAlchemy table from the source entity. The .yml component's attributes are treated as columns. 

These components should be typed. Besides, the FreeMarker template considers the following constraints:

* maxLength
* uniqueItems: sets "unique=True" for the column declaration.
* required: sets "nullable=False" for the column declaration.

## ${variables.entityName#cap_first}Routes.py.ftl
A FreeMarker template for the Python file declaring the application's paths. The application will request and return JSON objects. 

The paths are:

* `/[entityName]`: 
    * GET method: default path listing all entries to the entity table as a JSON object. Will return "List is empty" if there are no defined entries.
    * POST method: requests a JSON object defining an entry to the database. Adds and commits the entry to the database.
* `/[entityName]/[id]`:
    * GET method: returns a JSON object for the entry with the selected primary key.
    * PUT method: requests a JSON object defining one or more columns from the database. Updates and commits the entry with the selected primary key.
    * DELETE method: deletes the database entry with the selected primary key.
"# cobigen-python-templates" 
