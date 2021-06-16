from app import db

class ${variables.entityName?cap_first}(db.Model):
    id = db.Column(db.Integer, primary_key=True)
 <#list model.properties as property>
    <#if property.name!='id'>
    ${property.name?lower_case} = db.Column(db.${property.type?cap_first}<#if property.constraints.maxLength??>(${property.constraints.maxLength})</#if><#if property.constraints.unique==true>,unique=True</#if><#if property.constraints.notNull==true >,nullable=False</#if>)
    </#if>
</#list>
