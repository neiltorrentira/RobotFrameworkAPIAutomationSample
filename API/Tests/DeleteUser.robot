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
${id}               6409401696b2a7e55d9584fb

*** Test Cases ***
API Test: Delete User By ID
    [Tags]    Smoke
    Create Session      deleteUserByID       ${base_url}      disable_warnings=1
    ${headers}=         Create Dictionary   Content-Type=application/json
    ${endpoint}         Set Variable         /users/${id}
    ${response}=        DELETE On Session    deleteUserByID      ${endpoint}    headers=${headers}
    Log To Console      ${response.headers}
    Log To Console      ${response.status_code}
    Log To Console      ${response.content}
    Log                 ${response.content}

    # Validations
    ${status_code}=     Convert To String       ${response.status_code}
    Should Be Equal     ${status_code}          200
    ${headerValue}=     Get From Dictionary    ${response.headers}      Content-Type
    Should Be Equal     ${headerValue}         application/json

    ${json_response}=   Convert String To Json       ${response.content}
    ${contents}=        Get Value From Json          ${json_response}       ${id_path}
    Log To Console      ${json_response}
    Log To Console      ${contents}
    Should Be Empty     ${contents}






