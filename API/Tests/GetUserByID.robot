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
${id}               6407fd4ad8de739e4d5bab0d

*** Test Cases ***
API Test: Get User By ID
    [Tags]    Smoke
    Create Session      getUserByID       ${base_url}      disable_warnings=1
    ${headers}=         Create Dictionary   Content-Type=application/json
    ${endpoint}         Set Variable      /users/${id}
    ${response}=        GET On Session    getUserByID      ${endpoint}      headers=${headers}
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






