*** Settings ***
Documentation    Robot Framework Sample Tests

Library    Collections
Library    String
Library    JSONLibrary
Library    RequestsLibrary

*** Variables ***
${base_url}         http://localhost:8000

*** Test Cases ***
API Test: Get All Users
    [Tags]    Smoke
    Create Session      getAllUser       ${base_url}      disable_warnings=1
    ${endpoint}         Set Variable     /users
    ${response}=        GET On Session    getAllUser      ${endpoint}
    Log To Console      ${response.headers}
    Log To Console      ${response.status_code}
    Log To Console      ${response.content}
    Log                 ${response.content}

    # Validations
    ${status_code}=     Convert To String       ${response.status_code}
    Should Be Equal     ${status_code}          200
    Should Not Be Empty    ${response.content}

    ${headerValue}=     Get From Dictionary    ${response.headers}      Content-Type
    Should Be Equal     ${headerValue}         application/json






