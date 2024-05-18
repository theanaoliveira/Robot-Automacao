*** Settings ***
Library           RequestsLibrary
Documentation     Deve retornar a lista de componentes cadastrados de acordo com o tipo

*** Variables ***
${username}       user
${password}       password
${client_id}      clientId
${client_secret}  clientSecret
${content_type}   application/x-www-form-urlencoded

*** Test Cases ***

Chamar api para obter a lista de components
    Dado que eu acesse a tela de componentes
    Quando eu selecionar o tipo de componente desejado
    Então devo obter uma lista de componentes cadastrados de acordo com o tipo
    Ou devo obter um retorno de dados não encontrados

*** Keywords ***

Dado que eu acesse a tela de componentes
    Create Session      keycloak    http://keycloak.localhost

    ${data}=       Set Variable        grant_type=password&client_id=${client_id}&client_secret=${client_secret}&username=${username}&password=${password}
    ${headers}=    Create Dictionary   Content-Type=${content_type}
    ${response}=   POST On Session     keycloak    /realms/my_realm/protocol/openid-connect/token    headers=${headers}    data=${data}
    
    Log    ${response.status_code}
    Log    ${response.content}

    ${token}=    Set Variable    Bearer ${response.json()['access_token']}

    Log    ${token}

    Set Suite Variable    ${token}

Quando eu selecionar o tipo de componente desejado
    ${type}=     Set Variable    Button

    Set Suite Variable    ${type}

Então devo obter uma lista de componentes cadastrados de acordo com o tipo
    Create Session      components           http://localhost/components
    ${headers}=         Create Dictionary    Authorization=${token}
    ${response}=        GET On Session       components    /api/v1/Components    params=Type=${type}    headers=${headers}    expected_status=any
        
    Log    ${response.status_code}
    Log    ${response.content}
        
    Run Keyword If    ${response.status_code} == 200    Should Be Equal As Strings  ${type}  ${response.json()['typeComponent']}

    Set Suite Variable    ${response}

Ou devo obter um retorno de dados não encontrados
    Run Keyword If    ${response.status_code} == 404    Should Be Equal As Strings  Components or component not found  ${response.json()['detail']}