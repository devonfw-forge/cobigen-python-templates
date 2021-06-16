from app import app, ${variables.entityName?cap_first}Model, db
from flask import jsonify, request



@app.route('/')
@app.route('/${variables.entityName?lower_case}')
def ${variables.entityName?lower_case}_index():
    allRecords=${variables.entityName?cap_first}Model.${variables.entityName}.query.all()
    result=[]
    for item in allRecords:
        result.append({field.name: getattr(item, field.name) for field in item.__table__.columns})
    if(result):
        return jsonify(result)
    else:
        return "{} list is empty".format("${variables.entityName}")

@app.route('/${variables.entityName?lower_case}/<int:id>')
def get_${variables.entityName?lower_case}(id):
    record=${variables.entityName?cap_first}Model.${variables.entityName}.query.get(id)
    try:
        return jsonify({field.name: getattr(record, field.name) for field in record.__table__.columns})
    except:
        return "{} does not exist".format("${variables.entityName}")

@app.route('/${variables.entityName?lower_case}/<int:id>',methods=['DELETE'])
def delete_${variables.entityName?lower_case}(id):
    record=${variables.entityName?cap_first}Model.${variables.entityName}.query.get(id)
    try:
        db.session.delete(record)
        db.session.commit()
        return "{} deleted".format("${variables.entityName}")
    except:
        return "{} does not exist".format("${variables.entityName}")

@app.route('/${variables.entityName?lower_case}',methods=['POST'])
def add_${variables.entityName?lower_case}():
    record=${variables.entityName?cap_first}Model.${variables.entityName}()
    input = request.get_json()
    for field in ${variables.entityName?cap_first}Model.${variables.entityName}.__table__.columns:
        if field.name in input.keys():
            setattr(record,field.name,input[field.name])
    try:
        db.session.add(record)
        db.session.commit()
        return "{} added to database".format("${variables.entityName}")
    except:
        return "{} could not be added".format("${variables.entityName}")

@app.route('/${variables.entityName?lower_case}/<int:id>',methods=['PUT'])
def update_${variables.entityName?lower_case}(id):
    record=${variables.entityName?cap_first}Model.${variables.entityName}.query.get(id)
    input = request.get_json()
    try:
        for field in record.__table__.columns:
            if field.name in input.keys():
                setattr(record,field.name,input[field.name])
        db.session.commit()
        return "{} update submitted".format("${variables.entityName}")
    except:
        return "{} could not be updated".format("${variables.entityName}")
        