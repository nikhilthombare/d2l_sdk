require_relative 'requests'
########################
# Org Units:############
########################

# gets all descendents of a particular org unit, as referenced by the
# "org_unit_id" argument. A get request is then performed by a preformatted
# path.
def get_org_unit_descendants(org_unit_id, ou_type_id = 0)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/descendants/"
    path += "?ouTypeId=#{ou_type_id}" if ou_type_id != 0
    _get(path)
    # return json of org_unit descendants
end

# gets a paged result of the org unit's descendants. The descendants are
# first referenced by a preformatted path; then if there is a defined bookmark,
# the bookmark parameter is appended to the path.
#
# return: JSON array of org unit descendants (paged)
def get_paged_org_unit_descendants(org_unit_id, ou_type_id = 0, bookmark = '')
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/descendants/paged/"
    path += "?ouTypeId=#{ou_type_id}" if ou_type_id != 0
    path += "?bookmark=#{bookmark}" if bookmark != ''
    _get(path)
    # return paged json of org_unit descendants
end

# gets all parents of a particular org unit, as referenced by the
# "org_unit_id" argument. A get request is then performed by a preformatted
# path.
def get_org_unit_parents(org_unit_id, ou_type_id = 0)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/parents/"
    path += "?ouTypeId=#{ou_type_id}" if ou_type_id != 0
    _get(path)
    # return json of org_unit parents
end

# performs a post method to assign a parent to a particular child org unit.
# This is done by first referencing all the parents of the +child_ou+ and then
# POSTing the id of another org unit that is to be added to the parents.
def add_parent_to_org_unit(parent_ou_id, child_ou_id)
    # Must follow structure of data
    # (course <-- semester <== org -->custom dept--> dept -->templates--> courses)
    # Refer to valence documentation for further structural understanding..
    path = "/d2l/api/lp/#{$version}/orgstructure/#{child_ou_id}/parents/"
    _post(path, parent_ou_id)
end

# Gets all org unit ancestors. Simply, this method references all of the
# ancestors of the particular org unit and then returns them in a JSON array.
#
# return: JSON array of org_unit ancestors.
def get_org_unit_ancestors(org_unit_id, ou_type_id = 0)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/ancestors/"
    path += "?ouTypeId=#{ou_type_id}" if ou_type_id != 0
    _get(path)
    # return json of org_unit ancestors
end

# gets all children of a particular org unit, as referenced by the
# "org_unit_id" argument. A get request is then performed by a preformatted
# path.
def get_org_unit_children(org_unit_id, ou_type_id = 0)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/children/"
    path += "?ouTypeId=#{ou_type_id}" if ou_type_id != 0
    _get(path)
    # return json of org_unit children
end

# Gets all children of the org unit, but in a paged result. These are first
# referenced via the org_unit_id argument, and then a bookmark is appended
# if there is one specified. This is then returned as a json array.
#
# return: JSON array of org unit children.
def get_paged_org_unit_children(org_unit_id, bookmark = '')
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/children/paged/"
    path += "?bookmark=#{bookmark}" if bookmark != ''
    _get(path)
    # return json of org_unit children
end

# gets all properties of a particular org unit, as referenced by the
# "org_unit_id" argument. A get request is then performed by a preformatted
# path.
def get_org_unit_properties(org_unit_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}"
    _get(path)
    # return json of org_unit properties
end

# This deletes the relationship between a parent ou and a child ou by
# performing a delete method from the parent's children and specifying this
# child through its id.
def delete_relationship_of_child_with_parent(parent_ou_id, child_ou_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{parent_ou_id}/children/#{child_ou_id}"
    _delete(path)
end

# This deletes the relationship between a child ou and a parent ou by
# performing a delete method from the child's parents and specifying this
# parent through its id.
def delete_relationship_of_parent_with_child(parent_ou_id, child_ou_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{child_ou_id}/parents/#{parent_ou_id}"
    _delete(path)
end

# This retrieves a paged result of all the childless org units within the
# organization. As this is paged, it only retrieves the first 100 from the
# beginning of the request. If bookmark is not specified, then it only retrieves
# the first 100 results.
#
# return: JSON array of childless org units.
def get_all_childless_org_units(org_unit_type = '', org_unit_code = '', org_unit_name = '',
                                bookmark = '')
    path = "/d2l/api/lp/#{$version}/orgstructure/childless/"
    path += "?orgUnitType=#{org_unit_type}" if org_unit_type != ''
    path += "?orgUnitCode=#{org_unit_code}" if org_unit_code != ''
    path += "?orgUnitName=#{org_unit_name}" if org_unit_name != ''
    path += "?bookmark=#{bookmark}" if bookmark != ''
    _get(path)
    # ONLY RETRIEVES FIRST 100
end

# Retrieves a paged result of all orphaned org units within the organization.
# This is a paged result, so only for the first 100 from the beginning bookmark
# are retrieved. Simply put, if the bookmark is not defined, it only gets the
# first 100 orphans.
#
# return: JSON array of orphaned org units.
def get_all_orphans(org_unit_type = '', org_unit_code = '', org_unit_name = '',
                    bookmark = '')
    path = "/d2l/api/lp/#{$version}/orgstructure/orphans/"
    path += "?orgUnitType=#{org_unit_type}" if org_unit_type != ''
    path += "?orgUnitCode=#{org_unit_code}" if org_unit_code != ''
    path += "?orgUnitName=#{org_unit_name}" if org_unit_name != ''
    path += "?bookmark=#{bookmark}" if bookmark != ''
    _get(path)
end

# Adds a child to the org unit by using org_unit_id to reference the soon-to-be
# parent of the child_org_unit and referencing the soon-to-be child through the
# child_org_unit_id argument. Then, a path is created to reference the children
# of the soon-to-be parent and executing a post http method that adds the child.
#
# TL;DR, this adds a child org_unit to the children of an org_unit.
def add_child_org_unit(org_unit_id, child_org_unit_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}/children/"
    _post(path, child_org_unit_id)
end

# Retrieves a paged result of all recycled org units. Thus, only the first 100
# are retrieved since the first referenced org unit. As such, if the bookmark is
# not defined, then it only retrieves the first 100.
#
# return: JSON array of recycled org units.
def get_recycled_org_units(bookmark = '')
    path = "/d2l/api/lp/#{$version}/orgstructure/recyclebin/"
    path += "?bookmark=#{bookmark}" if bookmark != ''
    _get(path)
    # GETS ONLY FIRST 100
end

# An org unit is recycled by executing a POST http method and recycling it. The
# path for the recycling is created using the org_unit_id argument and then the
# post method is executed afterwards.
def recycle_org_unit(org_unit_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/recyclebin/#{org_unit_id}/recycle"
    _post(path, {})
end

# deletes a particular org unit. This is done via referencing the org unit by
# its id and performing a delete method.
def delete_recycled_org_unit(org_unit_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/recyclebin/#{org_unit_id}"
    _delete(path)
end

# Restores a recycled org unit. This is done by referencing the org unit by its
# id in the recycling bin and then appending '/restore'. This is then used in a
# post method that performs the restoring process.
def restore_recycled_org_unit(org_unit_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/recyclebin/#{org_unit_id}/restore"
    _post(path, {})
end

# Functions considered for basic added functionality to api, not sure if needed.
def create_custom_org_unit(org_unit_data)
    # Requires the type to have the correct parent. This will work fine in this
    # sample, as the department (101) can have the parent Organiation (6606)
    payload = { 'Type' => 101, # Number:D2LID
                'Name' => 'custom_ou_name', # String
                'Code' => 'custom_ou_code', # String
                'Parents' => [6606], # Number:D2LID
              }.merge!(org_unit_data)
    path = "/d2l/api/lp/#{$version}/orgstructure/"
    _post(path, payload)
end

def update_org_unit(org_unit_id, org_unit_data)
    previous_data = get_org_unit_properties(org_unit_id)
    payload = { # Can only update NAME, CODE, and PATH variables
        'Identifier' => org_unit_id.to_s, # String: D2LID // DO NOT CHANGE
        'Name' => previous_data['Name'], # String
        # String #YearNUM where NUM{sp:01,su:06,fl:08}  | nil
        'Code' => previous_data['Code'],
        # String: /content/enforced/IDENTIFIER-CODE/
        'Path' => "/content/enforced/#{org_unit_id}-#{previous_data['Code']}/",
        'Type' => previous_data['Type']
        # example:
        # { # DO NOT CHANGE THESE
        #    'Id' => 5, # <number:D2LID>
        #    'Code' => 'Semester', # <string>
        #    'Name' => 'Semester', # <string>
        # }
    }.merge!(org_unit_data)
    path = "/d2l/api/lp/#{$version}/orgstructure/#{org_unit_id}"
    puts '[-] Attempting put request (updating orgunit)...'
    _put(path, payload)
    puts '[+] Semester update completed successfully'.green
end

# Retrieves the organization info. Only gets a small amount of information,
# but may be useful in some instances.
def get_organization_info
    path = "/d2l/api/lp/#{$version}/organization/info"
    _get(path)
end

# Retrieves the org units that are a particular id. This is done by obtaining
# all of the children of the organization and then filtering by this id.
#
# return: JSON array of all org units of an outype.
def get_all_org_units_by_type_id(outype_id)
    path = "/d2l/api/lp/#{$version}/orgstructure/6606/children/?ouTypeId=#{outype_id}"
    _get(path)
end

# This retrieves information about a partituclar org unit type, referenced via
# the outype_id argument. This is then returned as a JSON object.
def get_outype(outype_id)
    path = "/d2l/api/lp/#{$version}/outypes/#{outype_id}"
    _get(path)
end

# retrieves all outypes that are known and visible. This is returned as a JSON
# array of orgunittype data blocks.
def get_all_outypes
    path = "/d2l/api/lp/#{$version}/outypes/"
    _get(path)
end
