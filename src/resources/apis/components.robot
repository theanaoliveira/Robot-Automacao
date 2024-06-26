*** Settings ***
Resource    ../main.robot

*** Variables ***
${base_url}     http://localhost/components

*** Keywords ***

Dado que eu selecione o tipo de componente desejado
    [Documentation]    Escolhe o tipo de componente desejado

    ${type}=     Set Variable    Button

    Set Suite Variable    ${type}

Quando clico em pesquisar
    [Documentation]     Executa o endpoint para listar os componentes de acordo com o tipo: ${type}

    Create Session      components           ${base_url}
    ${headers}=         Create Dictionary    Authorization=${token}
    ${response}=        GET On Session       components    /api/v1/Components    params=Type=${type}    headers=${headers}    expected_status=any
        
    Log    ${response.status_code}
    Log    ${response.content}
    
    Set Suite Variable    ${response}

E existem itens cadastrados
    [Documentation]     Verifica se o retorno da api foi 200 - Sucesso

    Should Be Equal As Integers    200    ${response.status_code}
    Log    ${response.status_code}

Então devo obter uma lista de componentes cadastrados de acordo com o tipo
    [Documentation]     Verifica se o retorno da api está de acordo com o esperado

    Should Be Equal As Strings    Button    ${response.json()['typeComponent']}
    Log    ${response.json()['typeComponent']}