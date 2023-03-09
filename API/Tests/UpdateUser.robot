*** Settings ***
Documentation    Robot Framework Sample Tests

Library    Collections
Library    String
Library    JSONLibrary
Library    RequestsLibrary

*** Variables ***
${base_url}         http://localhost:8000
${id_path}          $._id
# Hard coded "id" parameter, will fail if incorrect
${id}               6408c1310fd0d002b26cd113

*** Test Cases ***
API Test: Update User By ID
    [Tags]    Smoke
    Create Session      updateUser          ${base_url}      disable_warnings=1
    ${headers}=         Create Dictionary   Content-Type=application/json
    ${endpoint}         Set Variable        /users/${id}
    ${body}=            Create Dictionary       name=Jesse Pinkman   address=9809 Margo Street, Albuquerque, New Mexico 87104     email=jessepinkman@abq.com    password=Jesse123Edit
    ${response}=        PUT On Session          updateUser    ${endpoint}    headers=${headers}  json=${body}
    Log To Console      ${response.headers}
    Log To Console      ${response.status_code}
    Log To Console      ${response.content}
    Log                 ${response.content}

    # Validations
    ${status_code}=     Convert To String       ${response.status_code}
    Should Be Equal     ${status_code}          200

    ${json_response}=   Convert String To Json       ${response.content}
    ${contents}=        Get Value From Json          ${json_response}       ${id_path}
    Should Not Be Empty    ${contents}
    Log To Console      ${contents}







