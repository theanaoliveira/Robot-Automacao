*** Settings ***
Resource    ../main.robot

*** Variables ***
${username}        usuario
${password}        usuario
${client_id}       id
${client_secret}   secret
${content_type}    application/x-www-form-urlencoded
${keycloak_url}    http://localhost/keycloak
${keycloak_realm}  my_realm

*** Keywords ***

Dado que eu tenha acesso a tela de components
    Create Session      keycloak    ${keycloak_url}

    ${data}=       Set Variable        grant_type=password&client_id=${client_id}&client_secret=${client_secret}&username=${username}&password=${password}
    ${headers}=    Create Dictionary   Content-Type=${content_type}
    ${response}=   POST On Session     keycloak    /realms/${keycloak_realm}/protocol/openid-connect/token    headers=${headers}    data=${data}
    ${token}=      Set Variable        Bearer ${response.json()['access_token']}

    Set Suite Variable    ${token}